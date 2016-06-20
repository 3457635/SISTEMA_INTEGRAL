Public Class ctlLlegadasListado
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub sdsTiempos_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsTiempos.Selecting

    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        Dim eleccion = ddlLlegadas.SelectedValue
        Dim inicio = -1000
        Dim fin = 0
        Select Case eleccion
            Case 1
                inicio = 0
                fin = 15
            Case 2
                inicio = 16
                fin = 30
            Case 3
                inicio = 31
                fin = 60
            Case 4
                inicio = 61
                fin = 120
            Case 5
                inicio = 121
                fin = 1000
        End Select

        sdsTiempos.SelectParameters(0).DefaultValue = inicio
        sdsTiempos.SelectParameters(1).DefaultValue = fin
        sdsTiempos.SelectParameters(2).DefaultValue = DropDownList1.SelectedValue
        sdsTiempos.SelectParameters(3).DefaultValue = TextBox1.Text

    End Sub
End Class