Imports System.IO
Imports System.Net
Public Class EvaluacionChofer
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txbIdOrden.Text = Request("idOrden")
        hfdIdEquipo.Value = Request("idEquipo")
        hfldGrupo.Value = Request("grupo")
    End Sub


    Protected Sub llenarEvaluacion()
        Dim idOrden = txbIdOrden.Text
        Dim idChofer = DropDownList1.SelectedValue
        Dim idEquipo = hfdIdEquipo.Value

        Dim grupo = hfldGrupo.Value

            Obtener_rendimiento(idOrden, idChofer, grupo)

            sdsRuta.SelectParameters(0).DefaultValue = idChofer
            sdsRuta.SelectParameters(1).DefaultValue = grupo

            sqlSalida.SelectParameters(0).DefaultValue = grupo
            sqlSalida.SelectParameters(1).DefaultValue = idChofer
            sqlSalida.DataBind()





            sdsRecargas.SelectParameters(0).DefaultValue = grupo

            GridView6.DataBind()

            sdsRecargasInternas.SelectParameters(0).DefaultValue = grupo

            GridView7.DataBind()

            sqlArribos.SelectParameters(0).DefaultValue = idOrden
            sqlArribos.SelectParameters(1).DefaultValue = idChofer

            GridView2.DataBind()

            sdsRuta.DataBind()
        
    End Sub


    Protected Sub Obtener_rendimiento(ByVal idOrden As Integer,
                                      ByVal idChofer As Integer,
                                      ByVal grupo As Integer)

        Dim idEquipo = hfdIdEquipo.Value
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
            'buscar_odometro(idChofer, 2, grupo)

            Dim buscarOdometrosInicio = proxy.buscarOdometroPorGrupo(grupo, 1)

            'buscar_odometro(idChofer, 1, grupo)
            Dim kms As Integer = 0
            Dim Rendimiento As Decimal = 0
            Dim lts_total = proxy.regresarLtsPorGrupo(grupo)

            If Not buscarOdometrosRegreso Is Nothing And Not buscarOdometrosInicio Is Nothing Then
                Dim OdometroInicio = buscarOdometrosInicio.odometro1
                Dim OdometroRegreso = buscarOdometrosRegreso.odometro1

                If OdometroInicio <> 0 And OdometroRegreso <> 0 Then
                    kms = OdometroRegreso - OdometroInicio
                End If

                If kms <> 0 And lts_total <> 0 Then
                    Rendimiento = kms / lts_total
                End If
            End If


            Dim costo As Decimal = 0

            Dim buscarRendimiento = proxy.buscarRendimientoPorGrupo(grupo)


            If buscarRendimiento Is Nothing Then
                Dim nuevoRendimiento As New wcfRef1.rendimiento
                nuevoRendimiento.kms = kms
                nuevoRendimiento.lts = lts_total
                nuevoRendimiento.rendimiento1 = Rendimiento
                nuevoRendimiento.idEquipoAsignado = idEquipoAsignado
                nuevoRendimiento.grupo = grupo

                proxy.crearRendimiento(nuevoRendimiento)
            Else

                buscarRendimiento.kms = kms
                buscarRendimiento.lts = lts_total
                buscarRendimiento.rendimiento1 = Rendimiento
                buscarRendimiento.idEquipoAsignado = idEquipoAsignado
                buscarRendimiento.grupo = grupo

                proxy.actualizarRendimiento(buscarRendimiento)


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
            Dim idOrden = txbIdOrden.Text
            Dim idViaje = e.Row.Cells(0).Text
            Dim idEmpleado = e.Row.Cells(1).Text
            Dim idEquipoAsignado = e.Row.Cells(2).Text

            Dim idEquipo = hfdIdEquipo.Value
            Dim grupo = hfldGrupo.Value

            sdsTrayectos.SelectParameters(0).DefaultValue = idEquipoAsignado

            nuevoMargen(idViaje)


        End If

    End Sub

   

    

    Protected Sub ImageButton3_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar.Click
        llenarEvaluacion()

        Dim strURL As String
        'Dim strResult As String
        'Dim wbrq As HttpWebRequest
        'Dim wbrs As HttpWebResponse
        'Dim sr As StreamReader
        Dim idOrden = txbIdOrden.Text
        Dim idChofer = DropDownList1.SelectedValue
        Dim idEquipo = hfdIdEquipo.Value
        Dim grupo = hfldGrupo.Value


        ' Set the URL (and add any querystring values)  
        strURL = String.Format("http://tse-si.com/net2/evaluacionAbierta/EvaluacionChofer3.aspx?idOrden={0}&idEquipo={1}&idChofer={2}", idOrden, idEquipo, idChofer)


        ' Create the web request  
        'wbrq = WebRequest.Create(strURL)
        'wbrq.Method = "GET"

        ' Read the returned data   
        'wbrs = wbrq.GetResponse
        'sr = New StreamReader(wbrs.GetResponseStream)
        'strResult = sr.ReadToEnd.Trim

        'sr.Close()

        Dim buscarOrden = (From consulta In db.Ordenes
                        Where consulta.id_orden = txbIdOrden.Text
                        Select consulta).FirstOrDefault()


        Dim orden = String.Empty
        If Not buscarOrden Is Nothing Then
            orden = buscarOrden.consecutivo
        End If

        'Dim asunto = String.Format("Evaluacion Orden {0}", orden)

        'EnviarCorreo("auditoria@tse.com.mx,sistemas@tse.com.mx", asunto, strResult)
    End Sub

   


    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim sdsCaja As SqlDataSource = CType(e.Row.FindControl("sdsCajas"), SqlDataSource)
            Dim idEquipoAsignado = e.Row.Cells(0).Text
            sdsCaja.SelectParameters(0).DefaultValue = idEquipoAsignado


        End If
    End Sub
End Class