<%@ WebHandler Language="C#" Class="UEditorHandler" %>

using System;
using System.Web;
using System.IO;
using System.Collections;
using Newtonsoft.Json;

public class UEditorHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        Handler action = null;
        switch (context.Request["action"])
        {
            case "config":
                action = new ConfigHandler(context);
                break;
            case "uploadimage":
                action = new UploadHandler(context, new UploadConfig()
                {
                    AllowExtensions = MConfig.GetStringList("imageAllowFiles"),
                    PathFormat = MConfig.GetString("imagePathFormat"),
                    SizeLimit = MConfig.GetInt("imageMaxSize"),
                    UploadFieldName = MConfig.GetString("imageFieldName")
                });
                break;
            case "uploadscrawl":
                action = new UploadHandler(context, new UploadConfig()
                {
                    AllowExtensions = new string[] { ".png" },
                    PathFormat = MConfig.GetString("scrawlPathFormat"),
                    SizeLimit = MConfig.GetInt("scrawlMaxSize"),
                    UploadFieldName = MConfig.GetString("scrawlFieldName"),
                    Base64 = true,
                    Base64Filename = "scrawl.png"
                });
                break;
            case "uploadvideo":
                action = new UploadHandler(context, new UploadConfig()
                {
                    AllowExtensions = MConfig.GetStringList("videoAllowFiles"),
                    PathFormat = MConfig.GetString("videoPathFormat"),
                    SizeLimit = MConfig.GetInt("videoMaxSize"),
                    UploadFieldName = MConfig.GetString("videoFieldName")
                });
                break;
            case "uploadfile":
                action = new UploadHandler(context, new UploadConfig()
                {
                    AllowExtensions = MConfig.GetStringList("fileAllowFiles"),
                    PathFormat = MConfig.GetString("filePathFormat"),
                    SizeLimit = MConfig.GetInt("fileMaxSize"),
                    UploadFieldName = MConfig.GetString("fileFieldName")
                });
                break;
            case "listimage":
                action = new ListFileManager(context, MConfig.GetString("imageManagerListPath"), MConfig.GetStringList("imageManagerAllowFiles"));
                break;
            case "listfile":
                action = new ListFileManager(context, MConfig.GetString("fileManagerListPath"), MConfig.GetStringList("fileManagerAllowFiles"));
                break;
            case "catchimage":
                action = new CrawlerHandler(context);
                break;
            default:
                action = new NotSupportedHandler(context);
                break;
        }
        action.Process();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}