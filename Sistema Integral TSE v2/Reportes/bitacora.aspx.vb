Public Class bitacora
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim aTotal As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then
            If Session("popup") = 1 Then
                Dim nuevo_control_usuario = LoadControl("~/Controles_Usuario/ctlTarifaMultichofer.ascx")
                PlaceHolder1.Controls.Add(nuevo_control_usuario)
                mdlTarifa.Show()
            End If
            If Session("popup") = 2 Then
                Dim nuevo_control_usuario As UserControl = LoadControl("~/Controles_Usuario/ctlTarifaChofer.ascx")
                PlaceHolder1.Controls.Add(nuevo_control_usuario)
                mdlTarifa.Show()
            End If

        End If
    End Sub
    
    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizarD.Click
        lblMensaje.Text = String.Empty

        If txbFecha1.Text <> String.Empty And txbFecha2.Text <> String.Empty Then

            If ddlChofer.SelectedValue = 0 Then
                PorFecha()
            Else
                PorChofer()

                'sdsOrdenesRecolecciones.SelectParameters(0).DefaultValue = txbFecha1.Text
                'sdsOrdenesRecolecciones.SelectParameters(1).DefaultValue = txbFecha2.Text
                'sdsOrdenesRecolecciones.SelectParameters(2).DefaultValue = ddlChofer.SelectedValue

                lblMensaje.Text = "Espere..."
            End If

        Else
            lblMensaje.Text = "Seleccione la fecha."
        End If
    End Sub

    Protected Sub PorFecha()

        Dim fecha1 As Date = String.Format("{0} 00:00", txbFecha1.Text)
        Dim fecha2 As Date = String.Format("{0} 23:59", txbFecha2.Text)
        Dim bitacora = From consulta In db.fechas_viajes
                       Where consulta.fecha.tipo_fecha = 1 And consulta.fecha.fecha.Value.Date >= fecha1 And _
        consulta.viaje.id_status <> 5 _
                       And consulta.fecha.fecha.Value.Date <= fecha2
                       Select orden = consulta.viaje.Ordene.ano.ToString() + "-" + consulta.viaje.Ordene.consecutivo.ToString() + "-" + consulta.viaje.num_viaje.ToString(),
        consulta.viaje.precio.empresa.nombre,
        consulta.fecha.fecha,
        consulta.viaje.precio.llave_ruta.ruta,
        consulta.viaje.Ordene.consecutivo,
        consulta.viaje.id_viaje,
        consulta.viaje.verificado
                       Order By consecutivo Descending

        GridView4.DataSource = bitacora
        GridView4.DataBind()
    End Sub
    Protected Sub PorChofer()
        Dim fecha1 As Date = String.Format("{0} 00:00", txbFecha1.Text)
        Dim fecha2 As Date = String.Format("{0} 23:59", txbFecha2.Text)


        Dim bitacora = (From consulta In db.fechas_viajes,
                       consulta2 In db.equipo_asignados
                     Where consulta.fecha.tipo_fecha = 2 And
                     consulta.fecha.fecha.Value.Date >= fecha1 And
                     consulta.viaje.id_status = 4 And
                     consulta.fecha.fecha.Value.Date <= fecha2 And
                     consulta2.idEmpleado = ddlChofer.SelectedValue And
                     consulta.id_viaje = consulta2.ViajeId
Select orden = consulta.viaje.Ordene.ano.ToString() + "-" + consulta.viaje.Ordene.consecutivo.ToString() + "-" + consulta.viaje.num_viaje.ToString(),
                     consulta.viaje.precio.empresa.nombre,
                     consulta.fecha.fecha,
                     consulta.viaje.Ordene.consecutivo,
        consulta.viaje.precio.llave_ruta.ruta,
        consulta.viaje.id_viaje,
        consulta.viaje.verificado
).Distinct().OrderByDescending(Function(x) x.fecha)



        GridView4.DataSource = bitacora
        GridView4.DataBind()
        lblMensaje.Text = String.Empty
    End Sub

    Protected Sub GridView4_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView4.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim id_viaje = e.Row.Cells(0).Text



            Dim DataSourcechofer As SqlDataSource = CType(e.Row.FindControl("sdsChofer"), SqlDataSource)

            Dim DataSourceCaja As SqlDataSource = CType(e.Row.FindControl("sdsCaja"), SqlDataSource)
            Dim lblRecolecciones As Literal = CType(e.Row.FindControl("lblRecolecciones"), Literal)
            Dim DataSourceTrayectos As SqlDataSource = CType(e.Row.FindControl("sdsTrayectos"), SqlDataSource)
            Dim ltrPorcentaje As Literal = CType(e.Row.FindControl("ltrPorcentaje"), Literal)

            Dim lblFechaCierre As Label = CType(e.Row.FindControl("lblFechaCierre"), Label)

            Dim sdsTarifaUnichofer As SqlDataSource = CType(e.Row.FindControl("sdsTarifaUniChofer"), SqlDataSource)
            Dim sdsTarifaMultichofer As SqlDataSource = CType(e.Row.FindControl("sdsTarifaMultichofer"), SqlDataSource)
            Dim sdsFactura As SqlDataSource = CType(e.Row.FindControl("sdsFactura"), SqlDataSource)

            sdsTarifaMultichofer.SelectParameters(0).DefaultValue = id_viaje
            sdsTarifaUnichofer.SelectParameters(0).DefaultValue = id_viaje




            Dim busca_cierre = (From consulta In db.fechas_ordenes,
                              consulta2 In db.viajes
                              Where consulta.id_orden = consulta2.id_orden And
                              consulta2.id_viaje = id_viaje And
                              consulta.fecha.tipo_fecha = 2
                              Select consulta).FirstOrDefault()
            If Not busca_cierre Is Nothing Then
                lblFechaCierre.Text = busca_cierre.fecha.fecha.Value.Date.ToString("dd/MMM/yyyy")
            End If
            sdsFactura.SelectParameters(0).DefaultValue = id_viaje

            Dim Num_recolecciones = (From consulta In db.recolecciones
                                  Where consulta.id_viaje = id_viaje
                                  Select consulta.recolecciones).FirstOrDefault()

            DataSourcechofer.SelectParameters(0).DefaultValue = id_viaje

            DataSourceCaja.SelectParameters(0).DefaultValue = id_viaje
            DataSourceTrayectos.SelectParameters(0).DefaultValue = id_viaje

            If IsNumeric(Num_recolecciones) Then
                Dim tarifa_recolecciones = Num_recolecciones * 100
                lblRecolecciones.Text = String.Format("{0:c0}", tarifa_recolecciones)
                Me.aTotal += tarifa_recolecciones
            End If

            ''Rendimiento
            Dim buscar_orden = (From consulta In db.viajes
                         Where consulta.id_viaje = id_viaje
                         Select consulta).FirstOrDefault()

            If Not buscar_orden Is Nothing Then
                Dim id_orden = buscar_orden.id_orden

                Dim buscar_unidad = From consulta2 In db.equipo_asignados
                                  Where consulta2.ViajeId = id_viaje 
                                  Select consulta2

                Dim ltlRendimiento As Literal = CType(e.Row.FindControl("ltlRendimiento"), Literal)
                ltlRendimiento.Text = String.Empty

                For Each unit In buscar_unidad

                    Dim economico = unit.equipo_operacion.economico
                    Dim t_vehiculo = unit.equipo_operacion.tipo_equipo.equipo
                    Dim id_unidad = unit.equipo_operacion.id_equipo
                    Dim id_chofer = unit.idEmpleado
                    Dim EquipoAsignadoId = unit.id_equipo_asignado

                    Dim rendimiento = obtener_rendimiento(id_orden, id_unidad, id_chofer)

                    ltlRendimiento.Text += String.Format("{0} {1}:<u>{2:n2} </u><br>", t_vehiculo, economico, rendimiento)
                Next
            End If
        End If
        If e.Row.RowType = DataControlRowType.Footer Then
            Dim nomina = obtener_nomina_chofer(txbFecha1.Text, txbFecha2.Text, ddlChofer.SelectedValue)
            e.Row.Cells(12).Text = String.Format("{0:c}", nomina + Me.aTotal)
        End If

    End Sub
    
    Protected Sub ImageButton1_Click1(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        If Not String.IsNullOrEmpty(txbFecha1.Text) And Not String.IsNullOrEmpty(txbFecha2.Text) And ddlChofer.SelectedValue <> 0 Then
            Response.Redirect("~/Reportes/Reporte_Nomina.aspx?inicio=" + txbFecha1.Text + "&fin=" + txbFecha2.Text + "&id_chofer=" + ddlChofer.SelectedValue)
        End If



    End Sub

    Protected Sub GridView4_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView4.SelectedIndexChanged
        Dim id_viaje = GridView4.SelectedDataKey.Value.ToString()


        If IsNumeric(id_viaje) Then
            Dim nuevo_control_usuario As UserControl
            Dim datos_orden = (From consulta2 In db.equipo_asignados
                                            Where consulta2.ViajeId = id_viaje
                                            Select consulta2).FirstOrDefault()

            If Not datos_orden Is Nothing Then
                Session("id_cliente") = datos_orden.viaje.precio.id_empresa
                Session("id_ruta") = datos_orden.viaje.precio.id_ruta
                Session("id_tipo_vehiculo") = datos_orden.equipo_operacion.id_tipo_equipo

            End If

            Dim es_multichofer = (From consulta In db.trayectos_asignados
                               Where consulta.equipo_asignado.ViajeId = id_viaje
                               Select consulta.EquipoAsignadoId).Count()


            If es_multichofer > 0 Then

                nuevo_control_usuario = LoadControl("~/Controles_Usuario/ctlTarifaMultichofer.ascx")
                Session("popup") = 1
            Else
                nuevo_control_usuario = LoadControl("~/Controles_Usuario/ctlTarifaChofer.ascx")
                Session("popup") = 2
            End If
            mdlTarifa.Show()
            PlaceHolder1.Controls.Add(nuevo_control_usuario)


        End If

    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        If txbFecha1.Text <> "" And txbFecha2.Text <> "" Then
            If ddlChofer.SelectedValue = 0 Then
                PorFecha()
            Else
                PorChofer()
            End If

        Else
            lblMensaje.Text = "Seleccione la fecha."
        End If

        mdlTarifa.Hide()
        Session("popup") = 0
    End Sub
    ''' <summary>
    ''' Registro recolecciones de un viaje.
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        If IsNumeric(txbRecolecciones.Text) Then
            Dim idViaje = ddlViaje.SelectedValue
            Dim recolecciones = txbRecolecciones.Text

            Dim buscarRecolecciones = (From consulta In db.recolecciones
                                    Where consulta.id_viaje = idViaje
                                    Select consulta).FirstOrDefault()
            If Not buscarRecolecciones Is Nothing Then
                buscarRecolecciones.recolecciones = recolecciones

            Else

                Dim nuevaRecoleccion As New recoleccione With {.id_viaje = idViaje, .recolecciones = recolecciones}
                db.recolecciones.InsertOnSubmit(nuevaRecoleccion)

            End If
            db.SubmitChanges()
            txbRecolecciones.Text = String.Empty
            lblMensaje.Text = "Se registró la recoleccion en la orden " + ddlViaje.SelectedItem.ToString()
        End If
    End Sub

    
End Class