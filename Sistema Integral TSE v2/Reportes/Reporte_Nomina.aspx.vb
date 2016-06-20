Public Class Reporte_Nomina
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim aTotal As Integer
    Dim verUtilidad = 0
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim inicio As Date = Request("inicio")
        Dim fin As Date = Request("fin")
        Dim idChofer = Request("id_chofer")


        txbInicio.Text = inicio
        txbFin.Text = fin
        txbIdChofer.Text = idChofer

        


        lblFechas.Text = String.Format("{0:d} 00:00", txbInicio.Text)
        lblFecha2.Text = String.Format("{0:d} 23:59", txbFin.Text)
        Dim buscar_chofer = (From consulta In db.empleados
                          Where consulta.id_empleado = txbIdChofer.Text
                          Select nombre_chofer = consulta.persona.primer_nombre.ToString() + " " + consulta.persona.apellido_paterno.ToString()).FirstOrDefault()
        lblChofer.Text = buscar_chofer


        Dim bitacora = (From consulta In db.fechas_viajes,
                       consulta2 In db.equipo_asignados,
                       consulta3 In db.fechas_ordenes,
                       consulta4 In db.margens
                     Where consulta3.fecha.tipo_fecha = 2 And
                     consulta3.fecha.fecha.Value.Date >= txbInicio.Text And
                     consulta.fecha.tipo_fecha = 1 And
                     consulta.viaje.id_status = 4 And
                     consulta3.fecha.fecha.Value.Date <= txbFin.Text And
                     consulta2.idEmpleado = txbIdChofer.Text And
                     consulta.id_viaje = consulta2.ViajeId And
                     consulta.viaje.id_orden = consulta3.id_orden
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
    End Sub

    Protected Sub GridView4_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView4.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim id_viaje = e.Row.Cells(0).Text
            Dim id_empleado = txbIdChofer.Text

            Dim ltlMargen As Literal = CType(e.Row.FindControl("ltlMargen"), Literal)

            Dim DataSourcechofer As SqlDataSource = CType(e.Row.FindControl("sdsChofer"), SqlDataSource)

            Dim DataSourceCaja As SqlDataSource = CType(e.Row.FindControl("sdsCaja"), SqlDataSource)
            Dim lblRecolecciones As Label = CType(e.Row.FindControl("lblRecoleciones"), Label)
            Dim DataSourceTrayectos As SqlDataSource = CType(e.Row.FindControl("sdsTrayectos"), SqlDataSource)

            Dim lblFechaCierre As Label = CType(e.Row.FindControl("lblFechaCierre"), Label)


            Dim sdsTarifaMultichofer As SqlDataSource = CType(e.Row.FindControl("sdsTarifaMultichofer"), SqlDataSource)
            Dim sdsTarifaUnichofer As SqlDataSource = CType(e.Row.FindControl("sdsTarifaUnichofer"), SqlDataSource)

            'sdsTarifaUnichofer.SelectParameters(0).DefaultValue = id_viaje

            'sdsTarifaMultichofer.SelectParameters(0).DefaultValue = id_viaje
            'sdsTarifaMultichofer.SelectParameters(1).DefaultValue = id_empleado

            Dim busca_cierre = (From consulta In db.fechas_ordenes,
                              consulta2 In db.viajes
                              Where consulta.id_orden = consulta2.id_orden And
                              consulta2.id_viaje = id_viaje And
                              consulta.fecha.tipo_fecha = 2
                              Select consulta.fecha.fecha).FirstOrDefault()
            lblFechaCierre.Text = busca_cierre.Value.Date.ToString("dd/MMM/yyyy")

            

            Dim Num_recolecciones = (From consulta In db.recolecciones
                                  Where consulta.id_viaje = id_viaje
                                  Select consulta.recolecciones).FirstOrDefault()

            DataSourcechofer.SelectParameters(0).DefaultValue = id_viaje

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
                                  Where consulta2.ViajeId = id_viaje And
                                  consulta2.idEmpleado = id_empleado
                                  Select consulta2
                Dim ltlRendimiento As Literal = CType(e.Row.FindControl("ltlRendimiento"), Literal)
                ltlRendimiento.Text = String.Empty

                For Each unit In buscar_unidad

                    Dim economico = unit.equipo_operacion.economico
                    Dim t_vehiculo = unit.equipo_operacion.tipo_equipo.equipo
                    Dim id_unidad = unit.equipo_operacion.id_equipo
                    Dim id_chofer = unit.idEmpleado


                    Dim rendimiento = obtener_rendimiento(id_orden, id_unidad, id_chofer)

                    ltlRendimiento.Text += String.Format("{0} {1}: <u>{2:n2}</u><br>", t_vehiculo, economico, rendimiento)
                Next

            End If



        End If
        If e.Row.RowType = DataControlRowType.Footer Then
            Dim nomina = obtener_nomina_chofer(txbInicio.Text, txbFin.Text, txbIdChofer.Text)
            e.Row.Cells(11).Text = String.Format("{0:c}", nomina + Me.aTotal)
        End If
    End Sub
End Class