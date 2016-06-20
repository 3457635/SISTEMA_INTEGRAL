Public Class graficaMantemientoMensual
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim thisDate As Date
        Dim thisYear As Integer
        thisDate = Date.Now
        thisYear = Year(thisDate)
        TextBox1.Text = thisYear
    End Sub

End Class