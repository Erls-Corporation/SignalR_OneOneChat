using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR.Hubs;
using Microsoft.AspNet.SignalR.Transports;
using Microsoft.AspNet.SignalR.Infrastructure;
using Microsoft.AspNet.SignalR;
using System.Threading.Tasks;
using System.Timers;
using ChatSample;

/// <summary>
/// Summary description for chat
/// </summary>
    [HubName("chatHub")]
    public class Chat : Hub
    {
        public Task JoinGroup()
        {            
            return Groups.Add(Context.ConnectionId, "foo");            
        }

        public override Task OnConnected()
        {
            var newUsers = OnlineUser.userObj.Where(item => item.newStatus == true).Select(item => item.userId).ToList();            
            UserModal user = OnlineUser.userObj.Where(item => item.sessionId == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).SingleOrDefault();
            user.connectionId = Context.ConnectionId;
            return Clients.All.joined(Context.ConnectionId,newUsers);
        }

        public void Send(string message, string groupName)
        {
            if (Clients != null)
            {
                Clients.Group(groupName).addMessage(message,groupName);
            }
        }

        public void GetAllOnlineStatus()
        {
            Clients.Caller.OnlineStatus(Context.ConnectionId, OnlineUser.userObj.Select(item => item.userId).ToList());
        }

        public void CreateGroup(string currentUserId, string toConnectTo)
        {
            string strGroupName = GetUniqueGroupName(currentUserId, toConnectTo);
            string connectionId_To = OnlineUser.userObj.Where(item => item.userId == toConnectTo).Select(item=>item.connectionId).SingleOrDefault();
            if (!string.IsNullOrEmpty(connectionId_To))
            {
                Groups.Add(Context.ConnectionId, strGroupName);
                Groups.Add(connectionId_To, strGroupName);
                Clients.Caller.setChatWindow(strGroupName, toConnectTo);
            }
        }

        private string GetUniqueGroupName(string currentUserId, string toConnectTo)
        {
            return (currentUserId.GetHashCode() ^ toConnectTo.GetHashCode()).ToString();
        }
    }	 

