<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="testUpdatePanel.aspx.vb" Inherits="Sistema_Integral_TSE_v45.testUpdatePanel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="Button1" runat="server" Text="Button" />
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
            </ContentTemplate>
           
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
