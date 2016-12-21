<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="website.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>企业后台管理</title>
    <%-- easyUI引用部分--%>
    <link href="jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="jquery-easyui-1.5.1/demo/demo.css" rel="stylesheet" type="text/css" />
    <script src="jquery-easyui-1.5.1/jquery.min.js" type="text/javascript"></script>
    <script src="jquery-easyui-1.5.1/jquery.easyui.min.js" type="text/javascript"></script>
    <%-- easyUI引用部分--%>
    <link href="Styles/Site.css" rel="stylesheet" type="text/css" />
    <script src="scripts/index_AddTab.js" type="text/javascript"></script>
    <style>
    .sideorder{margin:10px;}   
    .sideorder li{width:150px;height:36px;background:rgba(224,236,255,0.8);margin-bottom:6px;border-radius:4px;line-height:36px;text-align:center;color:#353535;
                  transition: 0.3s;-moz-transition:0.3s;-webkit-transition:0.3s;-o-transition:0.3s;}
    .sideorder li a{font-size:16px;background:rgba(224,236,255,0.8);transition: 0.3s;-moz-transition:0.3s;-webkit-transition:0.3s;-o-transition:0.3s;}
    .after{padding-left:5px;background:#E0ECFF;}
    .easyui-linkbutton{background-image: url('images/');border:none;outline:none;}
    .easyui-linkbutton:hover{border:none;outline:none;}
    .l-btn-text{font-size:16px;}
    .top{background:url(images/top.jpg) bottom center;width:100%;height:100px;background-size:cover;color:#fff;font-size:40px;}
    .bottom{background:url(images/bottom.jpg) top center;width:100%;height:100px;background-size:cover;}
    </style>
</head>
<body class="easyui-layout">
    <!--顶部--Start---->
    <div data-options="region:'north',border:false" style="height: 100px; background: #E0ECFF;padding: 0px">
        <div class="top">
            企业网站后台
    	</div>
    </div>
    <!--顶部--End------------------->

    <!--左侧--Start---->
    <div data-options="region:'west',iconCls:'icon-setup',split:true,title:'菜单导航'" style="width: 180px;">
        <div class="easyui-accordion" style="width: 100%; height: 99%;">
            <ul class="sideorder">
                <li><a href="javascript:;" class="easyui-linkbutton" onclick=" AddTabByTitle('文章管理', 'ArticleMag.aspx');">文章管理</a></li>
                <li><a href="javascript:;" class="easyui-linkbutton" onclick=" AddTabByTitle('章管理', 'ArticleMag.aspx');">文章管理</a></li>
                <li><a href="javascript:;" class="easyui-linkbutton" onclick=" AddTabByTitle('文管理', 'ArticleMag.aspx');">文章管理</a></li>
            </ul>
        </div>
    </div>
    <!--左侧---End------------------>

    <!--中部--Start---->
    <div data-options="region:'center'">
        <!--tab面板开始--Start-->
        <div id="tabCenter" class="easyui-tabs" style="width: 100%; height:100%;">
        </div>
        <!--tab--End------------->
    </div>
    <!--中部--End------------------->

    <!--底部--Start---->
    <div data-options="region:'south',border:false" style="height: 100px; background: #E0ECFF;
        padding: 0px;">
          <div class="bottom">
    	  </div>
    </div>
    <!--底部--End------------------->
    <script>
        $(".sideorder li a").click(function () {
            $(".sideorder li a").removeClass("after");
            $(".sideorder li").removeClass("after");
            $(this).addClass("after");
            $(this).parents("li").addClass("after");
        });
    </script>
</body>
</html>
