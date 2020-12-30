from flask_restful import Resource,reqparse
from werkzeug.security import safe_str_cmp
from flask_jwt_extended import create_access_token,jwt_required
from db import query
import smtplib 
from email.message import EmailMessage

class User():
    def __init__(self,admin_id,password):
        self.admin_id=admin_id
        self.password=password

    @classmethod
    def getUserByadmin_id(cls,admin_id):
        result=query(f"""SELECT admin_id,password FROM admin WHERE admin_id='{admin_id}'""",return_json=False)
        if len(result)>0:  return User(result[0]['admin_id'],result[0]['password'])
        return False

class AdminLogin(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('admin_id',type=int,required=True,help="Admin_id cannot be left blank!")
        parser.add_argument("password",type=str,required=True,help="password cannot be left blank!")
        data=parser.parse_args()
        user=User.getUserByadmin_id(data['admin_id'])
        if user and safe_str_cmp(user.password,data['password']):
            access_token=create_access_token(identity=user.admin_id,expires_delta=False)
            return {"message":"ALLOW ACCESS !!"},200
        return {"message":"Invalid Credentials!"}, 401 

class AddCC(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('name',type=str,required=True,help="Name cannot be kept blank!")
        parser.add_argument('roll_no',type=str,required=True,help="Roll number cannot be kept blank!")
        parser.add_argument('club_id',type=int,required=True,help="Club_id cannot be kept blank!")
        parser.add_argument('ph_no',type=str,required=True,help="Phone Number cannot be kept blank!")
        parser.add_argument('email',type=str,required=True,help="Email Adress cannot be kept blank!")
        data=parser.parse_args()

        try:
            x=query(f"""SELECT * FROM CC where roll_no = '{data["roll_no"]}'""",return_json=False)
            
            if len(x)>0: 
                return {"message" : "CC member already exists with this Roll_no!"},400
            else:                
                query(f"""insert into CC(name,roll_no,club_id,ph_no,email) values('{data['name']}','{data['roll_no']}',
                            '{data['club_id']}','{data['ph_no']}','{data['email']}')""")
                query(f"""insert into login_details(user_id,password,role) values('{data['roll_no']}','{data['roll_no']}','CC')""")
        except:
            return {"message" :"Error in details"},500
        #return {"message":"Succesful"},201
        try:
            s = smtplib.SMTP("smtp.gmail.com", 587)
            s.ehlo()
            s.starttls()
            s.ehlo()
            s.login('cbit10793@gmail.com', 'admin@sudhee') 
            message = "LOGIN DETAILS"+"\n\n"+"user_id: " + data['roll_no'] + "\n" + "Password:  " + data['roll_no']
            s.sendmail("cbit10793@gmail.com", data['email'],message)  
            s.quit() 
            return {"message":"Succesfully sent a email given!"},201
        except:
            return {"message":"Unable to send mail"},500


class AddClub(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('club_name',type=str,required=True,help="Club_name cannot be kept blank!")
        parser.add_argument('club_id',type=int,required=True,help="Club_id cannot be kept blank!")
        parser.add_argument('branch',type=str,required=True,help="Branch cannot be kept blank!")
        data=parser.parse_args()
        try:
            x=query(f"""SELECT * FROM clubs where club_id = '{data["club_id"]}'""",return_json=False)
            if len(x)>0: 
                return {"message" : "Club already exists with this club_id!"},400
            else: 
                query(f""" insert into clubs(club_name,club_id,branch) 
                         values('{data['club_name']}','{data['club_id']}','{data['branch']}')""")
        except:
            return {"message" :"Error in details"},500
        return {"message":"Succesful"},201


class ClubId(Resource):
    def get(self):
        try:
            x=query(f"""select club_id from clubs """,return_json=False)
            if(len(x)>0):
                return query(f"""select club_id from clubs """,return_json=False)
            else:
                return {"message" : "No clubs are present!"},201
        except:
            return {"message" : "Can't connect to the table!"},500


class EventDetails(Resource):
    def get(self):
        try:
            x=query(f"""SELECT * FROM event_details""",return_json=False)
            if (len(x)>0):
                return query(f"""SELECT * FROM event_details""")
            else:
                return {"message" : "No events to display"},400
        except:
            return{"message":"Can't connect to events table"},500


class CCdetails(Resource):
    def get(self):
        try:
            x=query(f"""SELECT * FROM CC""",return_json=False)
            if (len(x)>0):
                return query(f"""SELECT * FROM CC""")
            else:
                return {"message" : "No CC member!"},400
        except:
            return{"message":"Can't connect to CC table"},500



