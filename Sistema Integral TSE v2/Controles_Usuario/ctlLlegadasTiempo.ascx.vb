Public Class ctlLlegadasTiempo
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            actualizarListado()
            txbAno.Text = Now.AddHours(-7).Year
            ddlMes.SelectedValue = Now.AddHours(-7).Month
        End If
    End Sub

    Private Sub actualizarListado()
        Dim eleccion = ddlLlegadas.SelectedValue
        Dim inicio = -1000
        Dim fin = 0
        Select Case eleccion
            Case 0
                inicio = -100000
                fin = -1
            Case 1
                inicio = 0
                fin = 60
            Case 2
                inicio = 61
                fin = 120
            Case 3
                inicio = 121
                fin = 100000
        End Select

        Dim tipo = "Con Arribo"
        If ddlLlegadas.SelectedValue = 4 Then
            tipo = "Local"
        ElseIf ddlLlegadas.SelectedValue = 5 Then
            tipo = "Sin Arribo"
        End If

        sdsListado.SelectParameters(2).DefaultValue = tipo
        sdsListado.SelectParameters(3).DefaultValue = inicio
        sdsListado.SelectParameters(4).DefaultValue = fin
    End Sub

    Protected Sub btnBuscarListado_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscarListado.Click
        actualizarListado()
    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        actualizarListado()
    End Sub
End Class