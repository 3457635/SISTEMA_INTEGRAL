Public Class ctlEvaluacionesPendientes
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            sdsEvaluaciones.SelectParameters(0).DefaultValue = Now.AddHours(-7).Month
            sdsEvaluaciones.SelectParameters(1).DefaultValue = Now.AddHours(-7).Year
        End If
    End Sub

End Class