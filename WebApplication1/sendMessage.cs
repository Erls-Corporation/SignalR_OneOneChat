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
using Microsoft.AspNet.SignalR.Hosting;


/// <summary>
/// Summary description for chat
/// </summary>
public class sendMessage : PersistentConnection
{

    protected override Task OnReceived(IRequest request, string clientId, string data)
    {
        //HttpContext.Current.Session["SignalRClientId"] = clientId;
        // Broadcast data to all clients
        return Connection.Broadcast(data);        
    }    
}