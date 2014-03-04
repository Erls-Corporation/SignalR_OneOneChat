using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.SignalR.Hosting;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Infrastructure;

namespace ChatSample
{
    public partial class Chat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (OnlineUser.userObj.Where(item => item.sessionId == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).Count() > 0)
                    OnlineUser.userObj.Remove(OnlineUser.userObj.Where(item => item.sessionId == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).FirstOrDefault());
                OnlineUser.AddOnlineUser("", HttpContext.Current.Session["UserName"].ToString(), HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString());
                hdnUserId.Value = Session["UserId"].ToString();
                hdnUserName.Value = Session["UserName"].ToString();
                lblUserName.Text = "Hello " + Session["UserName"].ToString();
            }
        }
    }
}