Public Class indicadores1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbConsultar.Text = Now.Year()
        End If
    End Sub

    Protected Sub DropDownList1_DataBound(sender As Object, e As EventArgs) Handles DropDownList1.DataBound
        Dim SelectItem As ListItem = New ListItem("Todos...", "Todos...")
        DropDownList1.Items.Insert(0, SelectItem)
        
    End Sub

    Protected Sub btnConsultar_Click(sender As Object, e As EventArgs) Handles btnConsultar.Click
        Session("unidad") = DropDownList1.SelectedValue
        Session("economico") = DropDownList2.SelectedValue
    End Sub

    Protected Sub DropDownList2_DataBound(sender As Object, e As EventArgs) Handles DropDownList2.DataBound
        Dim SelectItem As ListItem = New ListItem("Todos...", "Todos...")
        DropDownList2.Items.Insert(0, SelectItem)
        
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Server.Transfer("~/Mantenimiento/graficaCostosReparacion.aspx")
    End Sub
End Class