using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Text.RegularExpressions;

namespace website.admin.ashxFile
{
    /// <summary>
    /// Article 的摘要说明
    /// </summary>
    public class Article : IHttpHandler
    {
        private static string connStr = ConfigurationManager.ConnectionStrings["YouKeMeiConnectionString"].ToString();
        YouKeMeiDataContext ldc = new YouKeMeiDataContext(connStr);
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Buffer = true;
            context.Response.ExpiresAbsolute = System.DateTime.Now.AddMilliseconds(0);
            context.Response.Expires = 0;
            context.Response.CacheControl = "no-cache";
            context.Response.AppendHeader("Pragma", "No-Cache");

            //par参数决定功能
            string par = context.Request.QueryString["par"].ToString();
            switch (par)
            {
                case "getDate":
                    getDate(context);
                    break;
                case "AddArticle":
                    AddArticle(context);
                    break;
                case "EditArticle":
                    EditArticle(context);
                    break;
                case "DelArticle":
                    DelArticle(context);
                    break;
                case "getTypeList":
                    getTypeList(context);
                    break;
                default:
                    break;
            }
        }
        /// <summary>
        /// 获得文章信息列表
        /// </summary>
        /// <param name="context"></param>
        public void getDate(HttpContext context)
        {
            var Row = from r in ldc.tb_Article
                      orderby r.ID ascending
                      select new
                      {
                          r.ID,
                          r.Title,
                          r.Author,
                          r.InfoSummary,
                          r.InfoContent,
                          r.HitCount,
                          r.InfoType,
                      };
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string json = jss.Serialize(Row.ToList());
            context.Response.Write(json);
        }
        /// <summary>
        /// 添加文章信息
        /// </summary>
        /// <param name="context"></param>
        public void AddArticle(HttpContext context)
        {
            try
            {
                tb_Article objModel = new tb_Article();
                objModel.Title = context.Request.Form["Title"].ToString().Trim();
                objModel.Author = context.Request.Form["Author"].ToString().Trim();
                objModel.InfoType = context.Request["articleType"].ToString().Trim();
                objModel.PublishTime = Convert.ToDateTime(System.DateTime.Now.ToString()); 
                objModel.InfoSummary = context.Request.Form["InfoSummary"].ToString().Trim();
                objModel.InfoContent = context.Request["Article"].ToString().Trim();
                objModel.HitCount = 0;
                ldc.tb_Article.InsertOnSubmit(objModel);
                ldc.SubmitChanges();
                context.Response.Write("Succ");
                return;
            }
            catch (Exception ex)
            {
                context.Response.Write("error");
            }

        }
        /// <summary>
        /// 修改文章信息；
        /// </summary>
        /// <param name="context"></param>
        public void EditArticle(HttpContext context)
        {
            try
            {
                int ID = Convert.ToInt32(context.Request["id"]);
                var objtb = (from r in ldc.tb_Article
                             where r.ID == ID
                             select r).First();
                objtb.Title = context.Request.Form["Title"].ToString();
                objtb.Author = context.Request.Form["Author"].ToString();
                objtb.InfoType = context.Request["articleType"].ToString();
                objtb.InfoSummary = context.Request.Form["InfoSummary"].ToString();
                objtb.InfoContent = context.Request["Article"].ToString();
                ldc.SubmitChanges();
                context.Response.Write("Succ");
                return;
            }
            catch (Exception ext)
            {
                context.Response.Write("Error");
            }
        }
        /// <summary>
        /// 删除选中文章信息
        /// </summary>
        /// <param name="context"></param>
        public void DelArticle(HttpContext context)
        {
            string ID = context.Request["arrry[]"].ToString();
            string[] IDS = ID.Split(',');
            foreach (string e in IDS)
            {
                int id = Convert.ToInt32(e);
                var row = from r in ldc.tb_Article
                          where r.ID == id
                          select r;
                int count = row.Count();
                ldc.tb_Article.DeleteAllOnSubmit(row);
                ldc.SubmitChanges();
            }
            context.Response.Write("Succ");
        }
        /// <summary>
        /// 获得文章类型列表信息
        /// </summary>
        /// <param name="context"></param>
        private void getTypeList(HttpContext context)
        {
            try
            {
                var Rows = from r in ldc.tb_ArticleType
                           select r;
                JavaScriptSerializer jss = new JavaScriptSerializer();
                string jsonStr = jss.Serialize(Rows.ToList());
                context.Response.Write(jsonStr);
            }
            catch
            {
                context.Response.Write("Error");
            }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}