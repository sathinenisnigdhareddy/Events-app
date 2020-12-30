from flask_restful import Resource,reqparse
from werkzeug.security import safe_str_cmp
from flask_jwt_extended import create_access_token,jwt_required
from db import query
import smtplib 
from email.message import EmailMessage


class User():
    def __init__(self,user_id,password,role):
        self.user_id=user_id
        self.password=password
        self.role=role

    @classmethod
    def getUserByuser_id(cls,user_id):
        result=query(f"""SELECT user_id,password,role FROM login_details  WHERE user_id='{user_id}' """,return_json=False)
        if len(result)>0:  return User(result[0]['user_id'],result[0]['password'],result[0]["role"])
        return False


class UserLogin(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('user_id',type=str,required=True,help="user_id cannot be left blank!")
        parser.add_argument("password",type=str,required=True,help="password cannot be left blank!")
        parser.add_argument("role",type=str,required=True,help="role cannot be left blank!")
        data=parser.parse_args()
        user=User.getUserByuser_id(data['user_id'])
        if user and safe_str_cmp(user.password,data['password']) and safe_str_cmp(user.role,data['role']) and data['role']=='user':
            access_token=create_access_token(identity=user.user_id,expires_delta=False)
            details = query(f"""select * from users where user_id = '{data['user_id']}'""",return_json=False)
            return {"message":"Succesful","details":details},201
        return {"message":"Invalid Credentials!"}, 401 



class Favourites(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('user_id',type=str,required=True,help="user_id cannot be left blank!")
        parser.add_argument("event_name",type=str,required=True,help="event_name cannot be left blank!")
        parser.add_argument('event_branch',type=str,required=True,help="event_branch cannot be left blank!")
        data=parser.parse_args()
        try:
            x=query(f"""select * from registration where user_id='{data['user_id']}' and
                       event_name='{data['event_name']}'and event_branch='{data['event_branch']}'""",return_json=False)

            if(len(x)>0):
                if x[0]['isfav']=='True':
                    query(f"""update  registration set isfav='False' where user_id='{data['user_id']}' and
                       event_name='{data['event_name']}'and event_branch='{data['event_branch']}'""")
                    return {"message" : "This is not your fav event anymore"},201
                else:
                    query(f"""update  registration set isfav='True'where user_id='{data['user_id']}' and
                       event_name='{data['event_name']}'and event_branch='{data['event_branch']}'""")
                    return {"message": "Added to Favourites"},201
            else:
    
                z=query(f"""select event_id from event_details where event_name = '{data["event_name"]}' and
                                                                     event_branch ='{data["event_branch"]}'""",return_json=False)

                query(f"""insert into registration(user_id,event_id,event_name,event_branch,isfav,registration_status)
                                                    values('{data['user_id']}','{z[0]['event_id']}','{data['event_name']}','{data['event_branch']}',
                                                    'True','False') """ )
                return{"message" : "Added to Favourites"},201
        except:
            return {"message"  : "Error!"},500



class Registration(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('user_id',type=str,required=True,help="user_id cannot be left blank!")
        parser.add_argument("event_name",type=str,required=True,help="event_name cannot be left blank!")
        parser.add_argument('event_branch',type=str,required=True,help="event_branch cannot be left blank!")
        data=parser.parse_args()
        try:
            x=query(f"""select * from registration where user_id='{data['user_id']}' and
                       event_name='{data['event_name']}'and event_branch='{data['event_branch']}'""",return_json=False)

            if(len(x)>0):
                y=query(f"""select * from registration where user_id='{data['user_id']}' and 
                       event_name='{data['event_name']}'and event_branch='{data['event_branch']}'""",return_json=False)

                if(y[0]['registration_status']) == 'True':
                    return {"message" : "Already Registered!"},400

                else:
                    query(f"""update registration set registration_status='True' where user_id='{data['user_id']}' and
                       event_name='{data['event_name']}'and event_branch='{data['event_branch']}'""")
                    return { "message" : "Successfully Registered!"},201
            else:
                z=query(f"""select event_id from event_details where event_name = '{data["event_name"]}' and
                                                                     event_branch ='{data["event_branch"]}'""",return_json=False)
                
                query(f"""insert into registration(user_id,event_id,event_name,event_branch,isfav,registration_status)
                                                    values('{data['user_id']}','{z[0]['event_id']}','{data['event_name']}','{data['event_branch']}',
                                                    'False','True') """ )
                return { "message" : "Successfully Registered!"},201
        except:
            return {"message" : "Error in connecting to table"},500


class UserForgotPassword(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('user_id',type=str,required=True,help="user_id cannot be left blank!")
        
        data=parser.parse_args()
        try:
            z=query(f"""select * from users where user_id = '{data['user_id']}'""",return_json=False)
            if(len(z)>0):
                x=query(f"""select password from login_details where user_id = '{data['user_id']}'""",return_json=False)
                y=query(f"""select email from users where user_id= '{data['user_id']}'""",return_json=False)
                s = smtplib.SMTP("smtp.gmail.com", 587)
                s.ehlo()
                s.starttls()
                s.ehlo()
                s.login('cbit10793@gmail.com', 'admin@sudhee') 
                message = "\""+ x[0]['password']+"\""  +"  was your password"
                s.sendmail("cbit10793@gmail.com",y[0]['email'],message)  
                s.quit() 
                return {"message":"Succesfully sent to your mail!"},201
            else:
                return {"message" : "No user is present with the given user_id]"},400    
        except:
            return {"message":"Unable to send mail"},500
    

class Signup(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('name',type=str,required=True,help="Name cabbot be left blank!")
        parser.add_argument('user_id',type=str,required=True,help="user_id cannot be kept blank!")
        parser.add_argument('password',type=str,required=True,help="Password cannot be kept blank!")
        parser.add_argument('phone_no',type=str,required=True,help="phone_no cannot be kept blank!")
        parser.add_argument('email',type=str,required=True,help="email cannot be kept blank!")
        data=parser.parse_args()
        try:
            x=query(f"""SELECT * FROM users where user_id = '{data["user_id"]}' """,return_json=False)
            if len(x)>0: 
                return {"message" : "user  already  exists!"},400
            else: 
                query(f""" insert into users(user_id,password,phone_no,email,name) 
                     values('{data['user_id']}','{data['password']}','{data['phone_no']}','{data['email']}','{data['name']}')""")
                query(f""" insert into login_details(user_id,password,role) 
                     values('{data['user_id']}','{data['password']}','user')""")

                return {"message":"Succesful"},201 
        except:
            return {"message" :"Error in details"},500
        


class Getdetails(Resource):
    def post(self):
        parser=reqparse.RequestParser()
        parser.add_argument('event_branch',type=str,required=True,help="event_branch cannot be left blank!")
        data=parser.parse_args()
        try:
            return query(f"""SELECT * FROM event_details  WHERE event_branch='{data['event_branch']}' """,return_json=True)
        except:
            return{"message":"there was an error connecting to events table"},500


class Displayfav(Resource):
    def get(self):
        parser=reqparse.RequestParser()
        parser.add_argument('user_id',type=str,required=True,help="user_id cannot be left blank!")  
        data=parser.parse_args()
        try:
            b= query(f"""SELECT * FROM event_details  WHERE event_name in (select event_name from registration where user_id='{data['user_id']}' and isfav='yes') """,return_json=False)

            if(len(b)>0):
                return query(f"""SELECT * FROM event_details  WHERE event_name in (select event_name from registration where user_id='{data['user_id']}' and isfav='yes') """,return_json=True)
            else:
                return{"message":"no favourite events"},404
        except:
            return{"message":"there was an error connecting to registration table"},400



