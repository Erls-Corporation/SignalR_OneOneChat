using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ChatSample
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string user = txtUserName.Text;
            Session["UserName"] = txtUserName.Text;
            Session["UserId"] = user == "kedar" ? "111" : user == "abc" ? "222" : user == "xyz" ? "333" : "";
            FormsAuthentication.RedirectFromLoginPage(txtUserName.Text, true);
            Response.Redirect("Chat.aspx");
        }
    }
}