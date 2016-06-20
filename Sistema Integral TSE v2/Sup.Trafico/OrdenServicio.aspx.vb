Public Class OrdenServicio
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            DropDownList1.SelectedValue = Request.Params("id_viaje")


        End If
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        ReportViewer1.LocalReport.Refresh()
        ReportViewer2.LocalReport.Refresh()

    End Sub

    
End Class