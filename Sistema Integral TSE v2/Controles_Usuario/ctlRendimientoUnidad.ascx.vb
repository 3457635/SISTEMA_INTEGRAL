Public Class ctlRendimientoUnidad
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
           
        End If
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim inicio = String.Format("{0} 00:00", txbInicio.Text)
        'Dim fin = String.Format("{0} 23:59", txbFin.Text)

        sdsRendimiento.SelectParameters(0).DefaultValue = inicio
        'sdsRendimiento.SelectParameters(1).DefaultValue = fin
    End Sub


    Protected Sub sdsRendimiento_Selected(sender As Object, e As SqlDataSourceStatusEventArgs) Handles sdsRendimiento.Selected

    End Sub
End Class