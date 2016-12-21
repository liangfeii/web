<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="articleEdit.aspx.cs" Inherits="website.admin.articleEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>文章修改</title>
    <%-- easyUI引用部分--%>
    <link href="jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="jquery-easyui-1.5.1/demo/demo.css" rel="stylesheet" type="text/css" />
    <script src="jquery-easyui-1.5.1/jquery.min.js" type="text/javascript"></script>
    <script src="jquery-easyui-1.5.1/jquery.easyui.min.js" type="text/javascript"></script>
    <%-- easyUI引用部分--%>
    <script src="ueditor/ueditor.config.js" type="text/javascript"></script>
    <script src="ueditor/ueditor.all.min.js" type="text/javascript"></script>
    <script src="ueditor/lang/zh-cn/zh-cn.js" type="text/javascript"></script>
    <style>
    ul{list-style-type: none;margin:0;padding:0;background:#E5ECF2;}
    li{list-style-type: none;padding:5px 0 5px 20px;font-family:微软雅黑;}
    input{width:360px;height:26px;border:1px solid #BCBDC0;border-radius:4px;}
    body{background:#FDFEFF;font-size:16px}
    fieldset{border:1px dotted #353535;}    
    legend{font-size:16px;color:#353535;font-weight:bold;}
    .title{padding:10px 0 10px 20px;font-family:微软雅黑;}
    .title input{width:360px;height:26px;}
    .align{text-align:justify;width:80px;display:inline-block;}
    .conbutton{padding-right:100px;}
    .conbutton span{display:inline-block;padding:5px;border:1px solid #95BDFD;font-family:微软雅黑;border-radius:4px;font-size:16px;margin-right:16px;float:right;}
    .conbutton span:hover{background:#FDFEFF;}
    </style>
    <script type="text/javascript">
        //实例化编辑器
        //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
        $(function () {
            var ue = UE.getEditor('editor');
            ue.ready(function () {
                ue.setContent($("#content_").val());
            })
            $("#Title").textbox('setValue', "<%=title %>");
            $("#Author").textbox('setValue', "<%=Author %>");
            $("#InfoSummary").textbox('setValue', "<%=InfoSummary %>");
            $("#InfoType").combobox('setValue', "<%=InfoType %>");
        });
        //获取表单信息，提交
        function editArticle() {
            if ($('#Title').textbox('getValue') == "") {
                alert('请输入文章标题！');
                return;
            }
            if ($('#Author').textbox('getValue') == "") {
                alert('请输入作者！');
                return;
            }
            if ($('#InfoSummary').textbox('getValue') == "") {
                alert('请输入文章摘要！');
                return;
            }
            if ($('#InfoType').combobox('getText') == "") {
                alert('请输入文章类型！');
                return;
            }
            if (UE.getEditor('editor').getContent() == "") {
                alert('请输入文章内容！');
                return;
            } else {
                $("#frmeditArticle").form('submit', {
                    onSubmit: function (param) {
                        param.id=<%=id %>;
                        param.articleType = $("#InfoType").combobox('getText');
                        param.Article = UE.getEditor('editor').getContent(); //获取编辑器内容
                    }, success: function (data) {
                        if (data == 'Succ') {
                            alert('文章修改成功！');
                            window.location.href = "ArticleMag.aspx";
                        }
                        if (data == 'error') {
                            alert('文章修改失败！');
                        }

                    }
                });
            }
        }

        //清除表单内容
        function infoclear() {
//            $("input").val("");
//            $("#Title").textbox('clear');
//            $("#Author").textbox('clear');
//            $("#InfoType").textbox('clear');
//            $("#PictureURL").textbox('clear');
//            $("#AttachmentURL").textbox('clear');
//            $("#InfoSummary").textbox('clear');
//            //对编辑器的操作最好在编辑器ready之后再做
//            ue.ready(function () {
//                //设置编辑器的内容
//                ue.setContent('');
//            });
            $("#Title").textbox('setValue', "<%=title %>");
            $("#Author").textbox('setValue', "<%=Author %>");
            $("#InfoSummary").textbox('setValue', "<%=InfoSummary %>");
            $("#InfoType").combobox('setValue', "<%=InfoType %>");
            var ue = UE.getEditor('editor');
            ue.ready(function () {
                ue.setContent($("#content_").val());
            })
        }
    </script>
</head>
<body>
    <!--添加文章-->
    
    <fieldset >
     <legend>文章修改</legend>
        <form id="frmeditArticle" runat="server" method="post" class="form-horizontal" action="ashxFile/Article.ashx?par=EditArticle">
         <div class="title">
              <p class="align">文章标题：</p><input id="Title" name="Title" class="easyui-textbox"  style="height: 30px" />
         </div>
         <div class="neirong">
              <ul>
                   <li>
                       <p class="align">作者：</p><input id="Author" name="Author" class="easyui-textbox"  style="height: 30px" />
                   </li>
                   <li>
                       <p class="align">文章摘要：</p><input class="easyui-textbox" id="InfoSummary" name="InfoSummary" data-options="multiline:true"  style="height:60px;width:360px;"/>
                   </li>                  
                   <li>
                       <p class="align">文章类型：</p><input id="InfoType" name="InfoType" class="easyui-combobox" type="text"style="height: 30px"
                               editable="false" data-options="
				                url:'ashxFile/Article.ashx?par=getTypeList',
                                method:'get',
				                valueField:'ID',
				                textField:'ArticleType',
				                panelHeight:'auto'"/>
                   </li>
                   <li>
                        <p class="align">图片上传：</p>
                        <input type="file" id="" onchange="File()"/>
                   </li>
                   <li>
                       <p class="align" style="position:relative;float:left">文章内容：</p><script id="editor" type="text/plain" style="width:90%;height:500px;display:inline-block;float:left"></script>
                       <asp:HiddenField ID="content_" runat="server" />
                       <div style="clear:both"> 
                       </div>
                   </li>              
              </ul>
          
         </div>
    </from>
    <p class="conbutton"><span onclick="infoclear()">取消</span><span onclick="editArticle()">修改</span></p>
    </fieldset>   
    <!------------------------------end---------------------------------------->
    
        </form>
    
</body>
</html>