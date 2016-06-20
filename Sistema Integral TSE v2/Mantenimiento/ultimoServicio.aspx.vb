Public Class ultimoServicio
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    

    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim idRepacion = e.Row.Cells(0).Text
            Dim idEquipo = ddlEquipo.SelectedValue

            Dim ltlUltimo As Literal = CType(e.Row.FindControl("ltlUltimo"), Literal)
            Dim ltlSiguiente As Literal = CType(e.Row.FindControl("ltlSiguiente"), Literal)


            Dim buscarSiguienteServicio = (From consulta In db.preventivos
                                       Where consulta.id_equipo = idEquipo And
                                       consulta.reparacione.tipo_reparacion = idRepacion
                                       Select consulta Order By consulta.id Descending).FirstOrDefault()

            If Not buscarSiguienteServicio Is Nothing Then
                Try
                    ltlSiguiente.Text = buscarSiguienteServicio.proximoServicio
                    ltlUltimo.Text = buscarSiguienteServicio.reparacione.odometro
                Catch ex As Exception
                    lblMensaje.Text = ex.Message
                End Try

            End If



        End If
    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        Dim idEquipo = ddlEquipo.SelectedValue
        lblMensaje.Text = String.Empty

        Dim buscarKilometraje = (From consulta In db.Odometros
                                  Where consulta.id_equipo = idEquipo
                                  Select consulta Order By consulta.id_odometro Descending).FirstOrDefault()

        If Not buscarKilometraje Is Nothing Then
            ltlKilometraje.Text = "Kilometros recorridos:" + buscarKilometraje.odometro.ToString()
        End If

        GridView2.DataBind()

    End Sub
End Class