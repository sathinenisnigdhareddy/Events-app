from flask_restful import Resource,reqparse
from werkzeug.security import safe_str_cmp
from flask_jwt_extended import create_access_token,jwt_required
from db import query
import smtplib 
from email.message import EmailMessage



class Usercc():
    def __init__(self,user_id,password,role):
        self.user_id=user_id
        self.password=password
        self.role=role

    @classmethod
    def getUserByuser_id(cls,user_id):
        res=query(f"""SELECT user_id,password,role FROM login_details WHERE user_id='{user_id}'""",return_json=False)
        if len(res)>0:  return Usercc(res[0]['user_id'],res[0]['password'],res[0]['role'])
        return False

class CClogin(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('user_id',type=str,required=True,help="user_id cannot be left blank!")
        parser.add_argument("password",type=str,required=True,help="password cannot be left blank!")
        parser.add_argument("role",type=str,required=True,help="role cannot be left blank!")
        data=parser.parse_args()
        user=Usercc.getUserByuser_id(data['user_id'])
        if user and safe_str_cmp(user.password,data['password']) and  safe_str_cmp(user.role,data['role']) and data['role']=="CC":
            details=query(f"""select * from CC where roll_no = '{data['user_id']}'""",return_json=False)
            access_token=create_access_token(identity=user.user_id,expires_delta=False)
            return {"message":"ALLOW ACCESS !!","details" : details},200
        return {"message":"Invalid Credentials!"}, 401 

class ChangePassword(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('user_id',type=int,required=True,help="user_id cannot be left blank!")
        parser.add_argument("password",type=str,required=True,help="password cannot be left blank!")

        data=parser.parse_args()
        try:
            x=query(f"""SELECT * FROM login_details where user_id = '{data["user_id"]}'""",return_json=False)
            if len(x)>0: 
                
                    query(f"""update  login_details set password = '{data['password']}' where user_id = '{data["user_id"]}'""")
                    return {"message" : "Successfully changed password"},201
                
            else:
                return {"message" : "Entered user_id doesn't exist!"},400
        except:
            return {"message" : "Unable to Change Password"},500


class CCForgotPassword(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('roll_no',type=str,required=True,help="roll_no cannot be left blank!")
        data=parser.parse_args()
        try:
            z=query(f"""select * from CC where roll_no = '{data['roll_no']}'""",return_json=False)
            if(len(z)>0):
                x=query(f""" select email from CC where roll_no = '{data['roll_no']}'""",return_json=False)
                y=query(f""" select password from login_details where user_id = '{data['roll_no']}' and role like 'CC'""",return_json=False)
                s = smtplib.SMTP("smtp.gmail.com", 587)
                s.ehlo()
                s.starttls()
                s.ehlo()
                s.login('cbit10793@gmail.com', 'admin@sudhee') 
                message = "\""+ y[0]['password']+"\""  +"  was your password"
                s.sendmail("cbit10793@gmail.com",x[0]['email'],message)  
                s.quit() 
                return {"message":"Succesfully sent to your mail!"},201
            else:
                return {"message" : "No CC is present with the given roll_no"},400
            
        except:
            return {"message":"Unable to send mail"},500



class AddEvent(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('event_id',type=int,required=True,help="event_id cannot be left blank!")
        parser.add_argument("event_name",type=str,required=True,help="event_name cannot be left blank!")
        parser.add_argument('event_branch',type=str,required=True,help="event_branch cannot be left blank!")
        parser.add_argument('club_name',type=str,required=True,help="club_name cannot be left blank!")
        parser.add_argument('event_description',type=str,required=True,help="event_description cannot be left blank!")
        parser.add_argument('event_venue',type=str,required=True,help="user_id cannot be left blank!")
        parser.add_argument('event_loc',type=str,required=True,help="event_loc cannot be left blank!")
        data=parser.parse_args()

        try:
            x=query(f"""SELECT * FROM event_details where event_id = '{data["event_id"]}'""",return_json=False)
            if len(x)>0: 
                return {"message" : "Event already exists with this event_id!"},400
            else:
                query(f""" insert into event_details(event_id,event_name,event_branch,club_name,event_description,event_venue,event_loc) 
                            values({data['event_id']},'{data['event_name']}','{data['event_branch']}',
                                        '{data['club_name']}',
                                        '{data['event_description']}',
                                        '{data['event_venue']}',
                                        '{data['event_loc']}')""")
                return {"message":"Succesfully added event details"},201
        except:
            return {"message" :"Error in details can't add details"},500
        

class EditEvent(Resource):
     def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('event_id',type=int,required=True,help="event_id cannot be left blank!")
        parser.add_argument("event_name",type=str,required=True,help="event_name cannot be left blank!")
        parser.add_argument('event_branch',type=str,required=True,help="event_branch cannot be left blank!")
        parser.add_argument('club_name',type=str,required=True,help="club_name cannot be left blank!")
        parser.add_argument('event_description',type=str,required=True,help="event_description cannot be left blank!")
        parser.add_argument('event_venue',type=str,required=True,help="user_id cannot be left blank!")
        parser.add_argument('event_loc',type=str,required=True,help="event_loc cannot be left blank!")
        data=parser.parse_args()

        try:
            x=query(f"""SELECT * FROM event_details where event_id = '{data["event_id"]}'""",return_json=False)
            if len(x)>0: 
                print("if")
                query(f""" update event_details set
                                    event_name='{data['event_name']}',
                                    event_branch='{data['event_branch']}',
                                    club_name='{data['club_name']}',
                                    event_description='{data['event_description']}',
                                    event_venue='{data['event_venue']}',
                                    event_loc =  '{data['event_loc']}' 
                                    where event_id = '{data["event_id"]}'""")
                return {"message" : "Details are edited successfully!"},201
            else:
                return {"message"  : "Event_id doesn't exist"},400
        except:
            return {"message" :"Error in details can't edit"},500
        

class DeleteEvent(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('event_id',type=int,required=True,help="event_id cannot be left blank!")
        data=parser.parse_args()
        try:
                x=query(f"""SELECT * FROM event_details where event_id = '{data["event_id"]}'""",return_json=False)
                if len(x)>0: 
                    query(f"""delete from event_details where event_id = '{data["event_id"]}'""",return_json=False)
                    return {"message" : "Event is Succesfully deleted!"},201
                else:
                    return{"message":"This Event_id doesn't exist!"},400
        except:
            return{"message":"Wrong details entered can't delete the event"},500

class Registered(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('user_id',type=int,required=True,help="user_id cannot be left blank!")
        data=parser.parse_args()
        try:
            x= query(f"""SELECT *  from registration where registration_status='True' and event_id in
                        (select event_details.event_id from event_details,CC,clubs where CC.club_id = clubs.club_id and
							event_details.club_name = clubs.club_name and CC.roll_no ='{data['user_id']}')""",return_json=False)
                        
            if(len(x)>0):
                return query(f"""SELECT *  from registration where registration_status='True' and event_id in
                        (select event_details.event_id from event_details,CC,clubs where CC.club_id = clubs.club_id and
							event_details.club_name = clubs.club_name and CC.roll_no ='{data['user_id']}')""")
            else:
                return{"message":"None of the events is registered"},200
        except:
            return{"message" : "can't connect to the table"},500

        
           

