Public Class ctlCajasSinCobro
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblDias As Label = CType(e.Row.FindControl("lblDias"), Label)
            Dim id_renta = e.Row.Cells(0).Text


            Dim ultima_factura = (From consulta In db.facturas_cajas
                                  Where consulta.id_renta = id_renta
                                  Select consulta.fin Order By fin Descending).FirstOrDefault()

            lblDias.ForeColor = Drawing.Color.Black

            If Not ultima_factura Is Nothing Then
                Dim dias_transcurridos = (Now.AddHours(-7) - ultima_factura).Value.Days
                lblDias.Text = dias_transcurridos.ToString()
                If dias_transcurridos >= 31 Then
                    lblDias.ForeColor = Drawing.Color.Red
                    'EnviarCorreo("facturacion@tse.com.mx,sistemas@tse.com.mx", "Renta de Caja Atrazada", "Hay una caja que rebasa los 31 dias sin facturar")
                End If
            Else
                Dim inicio_renta = (From consulta In db.orden_cajas
                                 Where consulta.id_renta = id_renta
                                 Select consulta.Inicio).FirstOrDefault()

                If Not inicio_renta Is Nothing Then
                    Dim dias_transcurridos = (Now.AddHours(-7) - inicio_renta).Value.Days
                    lblDias.Text = dias_transcurridos.ToString()
                    If dias_transcurridos >= 31 Then
                        lblDias.ForeColor = Drawing.Color.Red
                        ''EnviarCorreo("facturacion@tse.com.mx,sistemas@tse.com.mx", "Renta de Caja Atrazada", "Hay una caja que rebasa los 31 dias sin facturar")
                    End If

                End If
            End If


        End If
    End Sub
End Class