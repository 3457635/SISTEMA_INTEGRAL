Public Class SinFactura_detalle
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            DropDownList1.Items.Insert(0, New ListItem("Todos...", "0"))

            Dim cantidad_mn = (From consulta In db.viajes, consulta3 In db.fechas_viajes
                                  Where Not (From consulta2 In db.facturacions
                                             Select consulta2.id_viaje).Contains(consulta.id_viaje) And
                                         consulta.id_viaje = consulta3.id_viaje And
                                         consulta.id_status <> 5 And
                                         consulta.remision = 0 And
                                         consulta.precio.id_moneda = 4
                                         Select consulta.precio.precio).Sum()

            lblMn.Text = String.Format("{0:c}", cantidad_mn)

            Dim cantidad_dls = (From consulta In db.viajes, consulta3 In db.fechas_viajes
                                   Where Not (From consulta2 In db.facturacions
                                              Select consulta2.id_viaje).Contains(consulta.id_viaje) And
                                          consulta.id_viaje = consulta3.id_viaje And
                                          consulta.id_status <> 5 And
                                          consulta.remision = 0 And
                                          consulta.precio.id_moneda = 5
                                          Select consulta.precio.precio).Sum()

            lblDolares.Text = String.Format("{0:c}", cantidad_dls)
            Dim viajes_sin_factura = (From consulta In db.viajes, consulta3 In db.fechas_viajes
                                     Where Not (From consulta2 In db.facturacions
                                                Select consulta2.id_viaje).Contains(consulta.id_viaje) And
                                            consulta.id_viaje = consulta3.id_viaje And
                                            consulta3.fecha.tipo_fecha = 1 And
                                            consulta.id_status <> 5 And consulta.remision = 0 And consulta.id_status <> 3
                                            Select consulta.id_viaje,
                                            orden = consulta.Ordene.ano.ToString() + "-" + consulta.Ordene.consecutivo.ToString() + "-" + consulta.num_viaje.ToString(),
                                            consulta.precio.empresa.nombre,
                                            consulta.precio.llave_ruta.ruta,
                                            consulta.precio.precio,
                                            consulta.verificado,
                                            dias = (Now().AddHours(-7) - consulta3.fecha.fecha).Value.Days,
                                            consulta3.fecha.fecha).OrderByDescending(Function(x) x.dias)

            GridView1.DataSource = viajes_sin_factura
            GridView1.DataBind()
        End If
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        If DropDownList1.SelectedValue <> 0 Then
            'Seleccionar un año para ver los viajes sin facturar 29 06 2015------------------------------------------
            'Omitir los remisionados 06/07/2015
            Dim viajes_sin_factura = (From consulta In db.viajes, consulta3 In db.fechas_viajes
                                    Where Not (From consulta2 In db.facturacions
                                               Select consulta2.id_viaje).Contains(consulta.id_viaje) And
                                           consulta.id_viaje = consulta3.id_viaje And
                                           consulta.id_status <> 5 And
                                           consulta.id_status <> 3 And
                                           consulta3.fecha.fecha.Value.Year = txbAñoSinFac.Text And
                                           consulta3.fecha.tipo_fecha = 1 And
                                           consulta.remision = 0 And
            consulta.precio.id_empresa = DropDownList1.SelectedValue
                                           Select consulta.id_viaje,
                                           orden = consulta.Ordene.ano.ToString() + "-" + consulta.Ordene.consecutivo.ToString() + "-" + consulta.num_viaje.ToString(),
                                           consulta.precio.empresa.nombre,
                                           consulta.precio.llave_ruta.ruta,
                                           consulta.verificado,
                                           consulta.precio.precio,
                                           dias = (Now().AddHours(-7) - consulta3.fecha.fecha).Value.Days,
                                           consulta3.fecha.fecha).OrderByDescending(Function(x) x.fecha)

            GridView1.DataSource = viajes_sin_factura
            GridView1.DataBind()




        Else
            'Seleccionar un año para ver los viajes sin facturar 29 06 2015 ------------------------------------------------
            Dim viajes_sin_factura = (From consulta In db.viajes, consulta3 In db.fechas_viajes
                                   Where Not (From consulta2 In db.facturacions
                                              Select consulta2.id_viaje).Contains(consulta.id_viaje) And
                                          consulta.id_viaje = consulta3.id_viaje And
                                          consulta.id_status <> 5 And
                                          consulta.id_status <> 3 And
                                          consulta.remision = 0 And
            consulta3.fecha.fecha.Value.Year = txbAñoSinFac.Text
                                          Select consulta.id_viaje,
                                          orden = consulta.Ordene.ano.ToString() + "-" + consulta.Ordene.consecutivo.ToString() + "-" + consulta.num_viaje.ToString(),
                                          consulta.precio.empresa.nombre,
                                          consulta.precio.llave_ruta.ruta,
                                          consulta.verificado,
                                          consulta.precio.precio,
                                          dias = (Now().AddHours(-7) - consulta3.fecha.fecha).Value.Days,
                                          consulta3.fecha.fecha).OrderByDescending(Function(x) x.fecha)

            GridView1.DataSource = viajes_sin_factura
            GridView1.DataBind()
        End If

    End Sub


    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim indicador As Image = CType(e.Row.FindControl("Image2"), Image)

            Dim dias As Integer
            If IsNumeric(e.Row.Cells(7).Text) Then
                dias = CInt(e.Row.Cells(7).Text)

                Select Case dias

                    Case 1 To 3
                        indicador.ImageUrl = "../imagenes/GREEN.png"
                    Case 4 To 7
                        indicador.ImageUrl = "../imagenes/YELLOW.png"
                    Case 7 To 14
                        indicador.ImageUrl = "../imagenes/AMBER.png"
                    Case Is > 14
                        indicador.ImageUrl = "../imagenes/RED.png"
                    Case Else
                        indicador.Visible = False

                End Select
            End If

        End If
    End Sub
End Class