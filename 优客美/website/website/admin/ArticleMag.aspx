<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArticleMag.aspx.cs" Inherits="website.admin.ArticleMag" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head  runat="server">
    <title>文章管理</title>
    <%-- easyUI引用部分--%>
    <link href="jquery-easyui-1.5.1/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="jquery-easyui-1.5.1/themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="jquery-easyui-1.5.1/demo/demo.css" rel="stylesheet" type="text/css" />
    <script src="jquery-easyui-1.5.1/jquery.min.js" type="text/javascript"></script>
    <script src="jquery-easyui-1.5.1/jquery.easyui.min.js" type="text/javascript"></script>
    <%-- easyUI引用部分--%>
    <script src="scripts/JSpageFilter.js" type="text/javascript"></script>
    <script src="scripts/Common.js" type="text/javascript"></script>
    <style>
        .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber
        {
            
            text-overflow: ellipsis;
        }
        a{text-decoration: none;margin-right:6px;}
    </style>
    <script type="text/javascript">
        //获得文章数据；
        GetArticleDate();
        function GetArticleDate() {
            $.post("ashxFile/Article.ashx?par=getDate", function (data, status) {
                $("#dgArticle").datagrid({ loadFilter: pagerFilter }).datagrid('loadData', eval(data));
            });
        }
        //添加文章窗口打开
        function AddEvent() {
            window.location.href = "article_Add.aspx";
        }

        //修改文章窗口打开
        function EditEvent(row) {
            window.location.href = 'articleEdit.aspx?id=' + row;
        }
        //删除操作
        function DelEventsin(row) {
            if (row.length == 0) {
                $.messager.alert('提示', '请至少选择一行数据！', 'warning');
                return false;
            }
            else {
                $.messager.confirm('删除信息提示', '确定要删除选中文章?', function (r) {
                    var ids = []; 
                        var id = row;     
                        ids.push(id);   
                    if (r) {
                        $.post("ashxFile/Article.ashx?par=DelArticle", { "arrry[]": ids }, function (data, stutus) {
                            if (data == 'Succ') {
                                GetArticleDate(); //刷新文章列表
                                layer.alert('文章删除成功！', { icon: 1 });
                                $("#dgArticle").datagrid("clearSelections");
                            }
                            else {
                                layer.alert('文章删除失败！', { icon: 2 });
                            }
                        });
                    }
                });
            }
        }
        //批量删除文章信息
        function DelEvent() {
            var row = $("#dgArticle").datagrid('getSelections'); //返回选中多行
            if (row.length == 0) {
                $.messager.alert('提示', '请至少选择一行数据！', 'warning');
                return false;
            }
            else {
                $.messager.confirm('删除信息提示', '确定要删除选中文章?', function (r) {
                    var ids = [];
                    for (var i = 0; i < row.length; i++) {
                        //获取自定义table 的中的checkbox值  
                        var id = row[i].ID;   //取的单个id   
                        ids.push(id);   //然后把单个id循环放到ids的数组中  
                    }
                    if (r) {
                        $.post("ashxFile/Article.ashx?par=DelArticle", { "arrry[]": ids }, function (data, stutus) {
                            if (data == 'Succ') {
                                GetArticleDate(); //刷新文章列表
                                layer.alert('文章删除成功！', { icon: 1 });
                                $("#dgArticle").datagrid("clearSelections");
                            }
                            else {
                                layer.alert('文章删除失败！', { icon: 2 });
                            }
                        });
                    }
                });
            }
        }


        //时间日期格式转换
        function dateFormate(value, row, index) {
            var datetime = Common.formatterDateTime(value);
            return datetime;
        }
        //去掉所有的html标记
        function formatHtml(value, row, index) {
            return value.replace(/<[^>]+>/g, ""); //正则表达式
        }
        //内容为空显示null
        function formatNull(value, row, index) {
            if (value != "") {
                return value;
            }
            if (value == "") {
                return value = "null";
            }
        }

        function operafun(val, row) {
            var rowID = row.ID;
            return '<a href="javascript:;" class="easyui-linkbutton" iconcls="icon-search2" plain="true" onclick="ArticleView()">查看</a><a href="javascript:;" class="easyui-linkbutton" iconcls="icon-wordInsert" plain="true" onclick="EditEvent(' + rowID + ')">修改</a><a href="javascript:;" class="easyui-linkbutton" iconcls="icon-del2" plain="true"onclick="DelEventsin(' + rowID + ')">删除</a>';
        }
    </script>
</head>
<body>
      
    <!--展示文章信息列表-->
    <table id="dgArticle" title="文章管理" class="easyui-datagrid" style="width: 100%; height: 650"
        toolbar="#toolbar" idfield="ID" rownumbers="true" fitcolumns="true" singleselect="false"
        ctrlselect="false" pagination="true" pagesize="10" sortname="ID" sortorder="asc"
        remotesort="false" striped="true" loadmsg="数据加载中请稍后..." nowrap="true" url="ashxFile/Article.ashx?par=getDate">
        <thead>
            <tr>
                <th field="Box" align="center" width="30" data-options="checkbox:true"></th>
                <th field="ID" align="center" width="30" sortable="true">
                    编号
                </th>
                <th field="Title" align="center" width="50">
                    文章标题
                </th>
                <th field="Author" align="center" width="50">
                    作者
                </th>
                <th field="InfoSummary" align="center" width="50" formatter="formatNull">
                    文章摘要
                </th>
                <th field="InfoContent" align="center" width="50" formatter="formatHtml">
                    文章内容
                </th>
                <th field="HitCount" align="center" width="40" sortable="true">
                    浏览次数
                </th>
                <th field="InfoType" align="center" width="50">
                    文章类型
                </th>
                <th field="operation" align="center" width="50" sortable="true" data-options="formatter:operafun" >
                    操作
                </th>

            </tr>
        </thead>
    </table>
    <div id="toolbar">
        <a href="javascript:;" class="easyui-linkbutton" iconcls="icon-add2" plain="true" onclick="AddEvent()">文章添加</a>
        <a href="javascript:;" class="easyui-linkbutton" iconcls="icon-del2" plain="true"onclick="DelEvent()">批量删除</a>              
    </div>
    <!------------------------------end---------------------------------------->
    
</body>
</html>
