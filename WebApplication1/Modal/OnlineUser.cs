using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ChatSample
{
    public static class OnlineUser
    {
        public static List<UserModal> userObj = new List<UserModal>();
        
        public static void AddOnlineUser(string strConnectionId, string strUserName,string strUserId,string strSessionId)
        {
            UserModal user = new UserModal();
            user.connectionId = strConnectionId;
            user.userName = strUserName;
            user.userId = strUserId;
            user.newStatus = true;
            user.sessionId = strSessionId;
            userObj.Add(user);
        }

        public static void RemoveOnlineUser(string strConnectionId, string strUserName,string strUserId)
        {
            var userRemove = (UserModal)userObj.Where(item => item.connectionId == strConnectionId && item.userName == strUserName);
            userObj.Remove(userRemove);            
        }
    }
}
