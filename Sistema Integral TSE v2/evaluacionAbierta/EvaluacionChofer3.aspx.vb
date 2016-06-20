Public Class EvaluacionChofer3
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim idOrden = Request("idOrden")
        Dim idEquipo = Request("idEquipo")
        Dim idChofer = Request("idChofer")
        llenarEvaluacion(idOrden, idEquipo, idChofer)
    End Sub


    Protected Sub llenarEvaluacion(ByVal idOrden As Integer,
                                   ByVal idEquipo As Integer,
                                   ByVal idChofer As Integer)

        
        hfdIdEquipo.Value = idEquipo

        Dim BuscarId = (From consulta In db.equipo_asignados
                             Where consulta.viaje.id_orden = idOrden And
                             consulta.idEmpleado = idChofer And
                             consulta.viaje.id_status <> 3 And
                             consulta.viaje.id_status <> 5 And
                             consulta.id_equipo = idEquipo
                             Select consulta).FirstOrDefault()


        If Not BuscarId Is Nothing Then

            Dim idEquipoAsignado = BuscarId.id_equipo_asignado

            Dim buscarGrupo = (From consulta In db.recorridoEquipos
                            Where consulta.idEquipoAsignado = idEquipoAsignado
                            Select consulta).FirstOrDefault()

            Dim grupo = 0

            If Not buscarGrupo Is Nothing Then
                grupo = buscarGrupo.grupo
            End If


            Obtener_rendimiento(idOrden, idChofer, idEquipo, grupo)

            sdsRuta.SelectParameters(0).DefaultValue = idChofer
            sdsRuta.SelectParameters(1).DefaultValue = grupo

            sqlSalida.SelectParameters(0).DefaultValue = grupo
            sqlSalida.SelectParameters(1).DefaultValue = idChofer
            sqlSalida.DataBind()

            sdsParcialesExternas.SelectParameters(0).DefaultValue = idChofer
            sdsParcialesExternas.SelectParameters(1).DefaultValue = idOrden
            sdsRecargas.SelectParameters(0).DefaultValue = idEquipoAsignado

            GridView6.DataBind()

            sdsRecargasInternas.SelectParameters(0).DefaultValue = idEquipoAsignado

            GridView7.DataBind()

            sqlArribos.SelectParameters(0).DefaultValue = idOrden
            sqlArribos.SelectParameters(1).DefaultValue = idChofer

            GridView2.DataBind()

            sdsRuta.DataBind()
        End If

    End Sub


    Protected Sub Obtener_rendimiento(ByVal idOrden As Integer,
                                      ByVal idChofer As Integer,
                                      ByVal idEquipo As Integer,
                                      ByVal grupo As Integer)


        'Rendimiento
        Dim buscar_unidad = From consulta In db.equipo_asignados
                            Where consulta.viaje.id_orden = idOrden And
                            consulta.idEmpleado = idChofer And
                            consulta.viaje.id_status <> 3 And
                            consulta.viaje.id_status <> 5 And
                            consulta.id_equipo = idEquipo And
                            consulta.equipo_operacion.id_tipo_equipo < 107
                            Select consulta

        Dim tabla As New HtmlTable

        For Each unidadAsignada In buscar_unidad

            Dim fila As New HtmlTableRow
            Dim celda1 As New HtmlTableCell
            Dim celda2 As New HtmlTableCell
            Dim idUnidad = unidadAsignada.id_equipo
            Dim idEquipoAsignado = unidadAsignada.id_equipo_asignado

            Dim chofer = unidadAsignada.empleado.persona.primer_nombre.ToString() + " " + unidadAsignada.empleado.persona.apellido_paterno.ToString()
            lblChofer.Text = chofer


            Dim buscarOdometrosRegreso = proxy.buscarOdometroPorGrupo(grupo, 2)

            Dim buscarOdometrosInicio = proxy.buscarOdometroPorGrupo(grupo, 1)


            Dim kms As Integer = 0


            If Not buscarOdometrosInicio Is Nothing And Not buscarOdometrosRegreso Is Nothing Then
                Dim odometroRegreso = buscarOdometrosRegreso.odometro1
                Dim odometroInicio = buscarOdometrosInicio.odometro1
                kms = odometroRegreso - odometroInicio
            End If

            Dim RecargasExternas = ObtenerRecargaExterna(grupo)
            Dim RecargasInternas = ObtenerRecargasInternas(grupo)

            Dim lts_total As Decimal = 0
            Dim costo As Decimal = 0

            lts_total = RecargasExternas + RecargasInternas

            Dim Rendimiento As Decimal = 0
            If kms <> 0 And lts_total <> 0 Then
                Rendimiento = kms / lts_total
            End If
            Dim Economico = ObtenerEconomicoUnidad(idUnidad)

            celda1.InnerHtml = "Unidad:<B>" + Economico + "</b> Kms:<b> " + CStr(kms) + "</b> lts: <B>" + CStr(lts_total) + "</b>"
            celda2.InnerHtml = "Rendimiento:<B>" + String.Format("{0:N2}", Rendimiento) + "</b>"

        

            fila.Cells.Add(celda1)
            fila.Cells.Add(celda2)
            tabla.Rows.Add(fila)
        Next
        PlaceHolder1.Controls.Add(tabla)

    End Sub
    Protected Sub GridView5_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView5.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim sdsTrayectos As SqlDataSource = CType(e.Row.FindControl("sdsTrayectoEnOrden"), SqlDataSource)
            Dim idOrden = e.Row.Cells(0).Text
            Dim idEmpleado = e.Row.Cells(1).Text
            Dim idEquipo = hfdIdEquipo.Value

            sdsTrayectos.SelectParameters(0).DefaultValue = idOrden
            sdsTrayectos.SelectParameters(1).DefaultValue = idEmpleado
            sdsTrayectos.SelectParameters(2).DefaultValue = idEquipo
        End If
    End Sub


    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim sdsCaja As SqlDataSource = CType(e.Row.FindControl("sdsCajas"), SqlDataSource)
            Dim idEquipoAsignado = e.Row.Cells(0).Text
            sdsCaja.SelectParameters(0).DefaultValue = idEquipoAsignado


        End If
    End Sub
End Class