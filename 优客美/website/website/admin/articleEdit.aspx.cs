using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace website.admin
{
    public partial class articleEdit : System.Web.UI.Page
    {
        private static string connStr = ConfigurationManager.ConnectionStrings["YouKeMeiConnectionString"].ToString();
        YouKeMeiDataContext ldc = new YouKeMeiDataContext(connStr);
        public int id;
        public string title;
        public string Author;
        public string InfoType;
        public string InfoSummary;
        public string InfoContent;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind();
            }
        }
        private void Bind()
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
            var row = from r in ldc.tb_Article
                      where r.ID == id
                      select r;
            if (row.Count() == 0)
            {
                //做没有数据的处理
                Response.Write("<script>alert('抱歉，没有所要修改的数据！');</script>");
            }
            else
            {
                title = row.First().Title.ToString();
                Author = row.First().Author.ToString();
                InfoType = row.First().InfoType.ToString();
                InfoSummary = row.First().InfoSummary.ToString();
                InfoContent = row.First().InfoContent.ToString();
                content_.Value = InfoContent;
            }
        }
    }
}

