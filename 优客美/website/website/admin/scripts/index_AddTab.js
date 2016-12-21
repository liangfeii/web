function AddTabByTitle(title, Url) {
    if ($('#tabCenter').tabs('exists', title)) {
        $('#tabCenter').tabs('select', title);
    } else {
        var content = '<iframe scrolling="auto" frameborder="0"  src="' + Url + '" style="width:100%;height:100%;"></iframe>';
        $('#tabCenter').tabs('add', {
            title: title,
            content: content,
            closable: true
        });
        $('#tabCenter').tabs('getSelected').css('width', 'auto');
    }
}
$(function () {
    AddTabByTitle('文章管理', 'ArticleMag.aspx');
})