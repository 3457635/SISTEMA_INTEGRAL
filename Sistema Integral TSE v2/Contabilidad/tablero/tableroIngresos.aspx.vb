Public Class tableroIngresos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlMesDuracion.SelectedValue = Now.AddHours(-7).Month
            txbAnoDuracion.Text = Now.AddHours(-7).Year

        End If


    End Sub


    Protected Sub btnConsultar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnConsultar.Click
        
    End Sub
End Class