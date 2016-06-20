Public Class ctlGraficaCartera_Global
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year()
            txbTC.Text = 13
            actualizarChart()
        End If
    End Sub
    Protected Sub actualizarChart()
        If IsNumeric(txbAno.Text) Then
            Dim ano = txbAno.Text
            sdsAnoActual.SelectParameters(0).DefaultValue = txbTC.Text
            sdsAnoActual.SelectParameters(1).DefaultValue = ano

            sdsAnoVencido.SelectParameters(0).DefaultValue = txbTC.Text
            sdsAnoVencido.SelectParameters(1).DefaultValue = ano

            sdsGlobal.SelectParameters(0).DefaultValue = txbTC.Text
            sdsGlobal.SelectParameters(1).DefaultValue = ano - 1

            sdsMensualActual.SelectParameters(0).DefaultValue = txbTC.Text
            sdsMensualActual.SelectParameters(1).DefaultValue = ano

            sdsVencidoPorCliente.SelectParameters(0).DefaultValue = txbTC.Text
            sdsVencidoPorCliente.SelectParameters(1).DefaultValue = ano

            sdsMensualAntiguo.SelectParameters(1).DefaultValue = ano - 1

            lblMesActual.Text = ano
            lblMesAnterior.Text = ano - 1

        End If

    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click

    End Sub

    Protected Sub rbtnAgrupar_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles rbtnAgrupar.SelectedIndexChanged

    End Sub

   
End Class