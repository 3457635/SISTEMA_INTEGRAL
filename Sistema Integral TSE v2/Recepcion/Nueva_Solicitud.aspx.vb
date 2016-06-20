Imports System.Data.SqlClient
Imports System.Data.Linq
Imports System.IO

Partial Public Class PruebaSolicitud
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If txbOrden.Text = "" Then
                lblOrden.Text = folio_orden()
            End If
            Dim dtFecha As DateTime = DateTime.Now.AddHours(-7)
            txbFechaInicio.Text = dtFecha.ToString("dd/MM/yyyy")
            lblFecha.Text = dtFecha.ToString("dd/MM/yyyy")

            Session("contactosSeguimiento") = 0
            Session("contactosSolicitud") = 0
            Session("arrivos") = 0
        Else
            If Session("contactosSeguimiento") = 1 Then
                cargarControlContactosSeguimiento()
            End If
            If Session("contactosSolicitud") = 1 Then
                cargarControlContactoSolicitud()
            End If
            If Session("arrivos") = 1 Then
                cargarControlArrivos()
            End If
        End If


        'CargarControlViajesSinRegreso()
    End Sub
    Protected Sub CargarControlViajesSinRegreso()
        PlaceHolder1.Controls.Clear()

        Dim control_viajes_sin_regreso As UserControl = LoadControl("~/Controles_Usuario/ctlViajesSinRegreso.ascx")
        PlaceHolder1.Controls.Add(control_viajes_sin_regreso)
    End Sub

    Protected Sub btnNumViaje_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNumViaje.Click
        If User.IsInRole("Facturacion") Then
            Return
        End If

        Dim id_contacto As Integer = ddlContacto.SelectedValue

        Dim idRelacion As Integer = ddlPrecio.SelectedValue

        comprobar_cotizacion_vencida(idRelacion)

        Dim hora As String = txbHoraInicio.Text
        Dim fecha_viaje_asignada As String = ""

        fecha_viaje_asignada = txbFechaInicio.Text + " " + hora


        If id_contacto = 0 Then
            lblAnuncio.Text = "Debe seleccionar el contacto."
        Else

            Dim guia = txbGuia.Text

            Dim idViaje = txbOrden.Text
            Dim idArrivo = Integer.Parse(ddlArrivo.SelectedValue)

            Dim llegadaADestino = String.Format("{0} {1}", txbFechaDestino.Text, txbHoraDestino.Text)

            If String.IsNullOrEmpty(txbOrden.Text) Then

                proxy.crearNuevaOrden(fecha_viaje_asignada, llegadaADestino, idRelacion, id_contacto, idArrivo, guia)
                lblOrden.Text = folio_orden()
                'viaje optimizado nuevo---------------------------------------------------
                ''Dim statusOptimizado = (From consulta In db.viajes
                ''                       Where consulta.id_viaje = idViaje
                ''                       Select consulta).FirstOrDefault()
                ''If Not statusOptimizado Is Nothing Then
                ''    statusOptimizado.optimizado = cbOptimizado.Checked
                ''    db.SubmitChanges()

                ''End If
                '--------------------------------------------------------------------------
                lblAnuncio.Text = "Listo!"
                Response.Redirect("~/Recepcion/Nueva_Solicitud.aspx")
            Else

                Dim buscarViaje = proxy.buscarViajePorId(idViaje) ' En el WCF no esta actualizado el diagrama de entities
                'por eso no se puede usar buscar viaje para modificar el bit optimizado

                'viaje optimizado modificacion---------------------------------------------------
                ' Marcar el viaje como optimizado 12 nov 2015 
                Dim statusOptimizado = (From consulta In db.viajes
                                       Where consulta.id_viaje = idViaje
                                       Select consulta).FirstOrDefault()
                If Not statusOptimizado Is Nothing Then
                    statusOptimizado.optimizado = cbOptimizado.Checked
                    db.SubmitChanges()
                
                End If
                '--------------------------------------------------------------------------------

                If buscarViaje.id_relacion <> idRelacion Then
                    buscarViaje.id_relacion = idRelacion

                    If buscarViaje.id_contacto <> id_contacto Then
                        buscarViaje.id_contacto = id_contacto
                    End If

                    proxy.actualizarViaje(buscarViaje)
                    lblAnuncio.Text = String.Format("Se actualizó la orden {0}", lblOrden.Text)
                    ddlCliente.DataBind()
                End If


                Dim buscarFechaSalida = proxy.buscarFechaPorIdViaje(idViaje, 1)

                If buscarFechaSalida.fecha1 <> fecha_viaje_asignada Then
                    buscarFechaSalida.fecha1 = fecha_viaje_asignada

                    proxy.actualizarFecha(buscarFechaSalida)

                    lblAnuncio.Text = String.Format("Se actualizó la orden {0}", lblOrden.Text)

                    ddlCliente.DataBind()

                End If

                Dim buscarDestino = proxy.buscarLlegadaPorIdViaje(idViaje)

                buscarDestino.fecha = llegadaADestino
                buscarDestino.idArrivo = ddlArrivo.SelectedValue

                proxy.actualizarLlegadaDestino(buscarDestino)

                sqlOrdenModificada.SelectParameters(0).DefaultValue = idViaje

                'Codigo que permite modificar la guia del cliente 16 06 2015 
                Dim updGuia = (From consulta In db.guias
                                 Where consulta.id_viaje = txbOrden.Text
                                 Select consulta).FirstOrDefault()
                updGuia.guia = txbGuia.Text
                db.SubmitChanges()
                '--------------------------------------------------------------------------------------------------------
                GridView1.DataBind()
            End If

        End If



    End Sub





    Public Function folio_orden() As String
        'Obtenemos el año actual para obtener el ultimo consecutivo


        Dim anoActual As String = Now.Year()

        Dim objConnectionSelect As New SqlConnection(strConnection)

        Dim orden As String = ""
        objConnectionSelect.Open()

        'Buscamos el ultimo numero consecutivo
        Dim strSQLselect As String = "SELECT MAX(consecutivo) AS consecutivo FROM ordenes WHERE ano=" + anoActual + ";"
        Dim objCommandselect As New SqlCommand(strSQLselect, objConnectionSelect)
        Dim lrdSelect As SqlDataReader = objCommandselect.ExecuteReader()

        If lrdSelect.Read() Then
            'Si el año aun no tiene ordenes de servicio asignamos el 1er consecutivo del año
            If lrdSelect("consecutivo") Is DBNull.Value Then
                orden = anoActual + "-1"
                txbConsecutivo.Text = "1"

            Else 'Si el año tiene consecutivos asignamos el siguiente
                Dim consecutivo As String = lrdSelect("consecutivo") + 1
                orden = anoActual + "-" + consecutivo
                txbConsecutivo.Text = consecutivo
            End If
        End If

        lrdSelect.Close()
        objConnectionSelect.Close()
        Return orden
    End Function


    Protected Sub ddlOrdenes_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlOrdenes.SelectedIndexChanged
        Dim db As New DataClasses1DataContext()
        txbOrden.Text = ddlOrdenes.SelectedValue
        txbGuia.Text = String.Empty
        Dim id_viaje = ddlOrdenes.SelectedValue

        Dim orden = (From consulta In db.viajes
                    Where consulta.id_viaje = id_viaje
                    Select consulta
                    ).FirstOrDefault()

        If Not orden Is Nothing Then

            Dim estatusPrecio = orden.precio.id_status

            If estatusPrecio = 6 Then
                txbIdRelacionBaja.Text = orden.precio.id_relacion
                orden.precio.id_status = 5
                db.SubmitChanges()
            End If

            lblOrden.Text = orden.Ordene.ano.ToString() + "-" + orden.Ordene.consecutivo.ToString() + "-" + orden.num_viaje.ToString()

            ddlCliente.SelectedValue = orden.precio.id_empresa
            ddlContacto.DataBind()
            ddlContacto.SelectedValue = orden.id_contacto
            ddlTrayecto.DataBind()
            ddlTrayecto.SelectedValue = orden.precio.id_ruta
            ddlIdTipoVehiculo.DataBind()
            ddlIdTipoVehiculo.SelectedValue = orden.precio.id_tipo_recurso
            ddlPrecio.DataBind()
            ddlPrecio.SelectedValue = orden.id_relacion
            ' Obtener el status del viaje si es optimizado o no y desplegarlo en el cbOptimizado 12 nov 2015
            If orden.optimizado Is Nothing Then
                cbOptimizado.Checked = False
            Else
                cbOptimizado.Checked = orden.optimizado.Value
            End If
            '--------------------------------------------------------------------------------------------

            Dim buscarArrivo = (From consulta In db.llegadaDestinos
                             Where consulta.idViaje = id_viaje
                             Select consulta).FirstOrDefault()

            If Not buscarArrivo Is Nothing Then

                Dim buscarDetalleArrivo = (From consulta In db.detalle_arrivos
                                        Where consulta.id_detalle = buscarArrivo.idArrivo And
                                        consulta.id_empresa = buscarArrivo.viaje.precio.id_empresa
                                        Select consulta).FirstOrDefault()

                If Not buscarDetalleArrivo Is Nothing Then
                    Dim modificar = False
                    If buscarDetalleArrivo.id_status = 6 Then
                        buscarDetalleArrivo.id_status = 5
                        db.SubmitChanges()
                        modificar = True
                    End If

                    ddlArrivo.DataBind()
                    ddlArrivo.SelectedValue = buscarArrivo.detalle_arrivo.id_detalle

                    If modificar Then
                        buscarDetalleArrivo.id_status = 6
                        db.SubmitChanges()
                    End If

                End If

                txbFechaDestino.Text = String.Format("{0:dd/MM/yyyy}", buscarArrivo.fecha)
                txbHoraDestino.Text = String.Format("{0:HH:mm}", buscarArrivo.fecha)
            End If

            Dim buscar_guia = (From consulta In db.guias
                            Where consulta.id_viaje = id_viaje
                            Select consulta).FirstOrDefault()
            If Not buscar_guia Is Nothing Then
                txbGuia.Text = buscar_guia.guia
            End If

            Dim fecha_viaje = (From consulta_fecha In db.fechas_viajes
            Where (consulta_fecha.id_viaje = ddlOrdenes.SelectedValue)
            Select consulta_fecha.fecha.fecha).First()

            txbFechaInicio.Text = CDate(fecha_viaje.ToString()).ToString("dd/MM/yyyy")
            txbHoraInicio.Text = CDate(fecha_viaje.ToString()).ToString("HH:mm")

            If Not String.IsNullOrEmpty(txbIdRelacionBaja.Text) Then
                Dim idRelacion = txbIdRelacionBaja.Text

                Dim buscarPrecio = (From consulta In db.precios
                                 Where consulta.id_relacion = idRelacion
                                 Select consulta).FirstOrDefault()

                If Not buscarPrecio Is Nothing Then
                    buscarPrecio.id_status = 6
                    db.SubmitChanges()
                End If
                txbIdRelacionBaja.Text = String.Empty
            End If

        Else
            lblAnuncio.Text = "Ocurrió un problema con la orden y no se puede seleccionar."
        End If

    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        If User.IsInRole("Facturacion") Then
            Return
        End If
        Response.Redirect("~/Recepcion/Nueva_Solicitud.aspx")
    End Sub

    Protected Sub btnEliminar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEliminar.Click
        If User.IsInRole("Facturacion") Then
            Return
        End If

        Dim db As New DataClasses1DataContext()
        If txbOrden.Text <> "" Then
            If Roles.IsUserInRole("Trafico") Or Roles.IsUserInRole("Administrador") Then
                Dim eliminar_viaje = (From consulta In db.viajes
                    Where (consulta.id_viaje = txbOrden.Text)
                                               Select consulta).First()
                eliminar_viaje.id_status = 5
                db.SubmitChanges()
                lblAnuncio.Text = "Se eliminó la orden " + lblOrden.Text
                btnNumViaje.Enabled = False
                ddlOrdenes.DataBind()
            Else
                lblAnuncio.Text = "Solo el dpto. de Tráfico puede eliminar ordenes."

            End If


        Else
            lblAnuncio.Text = "Seleccione la orden a eliminar."
        End If
    End Sub

    Protected Sub ddlOrdenes_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlOrdenes.DataBound
        ddlOrdenes.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub

    Protected Sub lnkContactos_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkContactos.Click
        If User.IsInRole("Facturacion") Then
            Return
        End If

        Session("idEmpresa") = ddlCliente.SelectedValue
        Session("idRuta") = ddlTrayecto.SelectedValue


        cargarControlContactosSeguimiento()

    End Sub
    Private Sub cargarControlContactosSeguimiento()
        Session("contactosSeguimiento") = 1
        Panel1_ModalPopupExtender.Show()
        Dim nuevoUsrCtl As UserControl = LoadControl("~/Controles_Usuario/ctlNuevaLista.ascx")
        PlaceHolder2.Controls.Add(nuevoUsrCtl)

    End Sub
    Private Sub cargarControlContactoSolicitud()
        Session("contactosSolicitud") = 1
        Panel1_ModalPopupExtender.Show()
        Dim nuevoUsrCtl As UserControl = LoadControl("~/Controles_Usuario/CtlNuevoContacto.ascx")
        PlaceHolder2.Controls.Add(nuevoUsrCtl)

    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        Session("contactosSeguimiento") = 0
        Session("contactosSolicitud") = 0
        Session("arrivos") = 0
        PlaceHolder2.Controls.Clear()
        Panel1_ModalPopupExtender.Hide()

        Dim idEmpresa = ddlCliente.SelectedValue
        Dim idRuta = ddlTrayecto.SelectedValue
        ddlArrivo.DataBind()
        lblContactos.Text = obtenerContactosSeguimiento(idEmpresa, idRuta)

        ddlContacto.DataBind()

    End Sub

    Protected Sub ddlTrayecto_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTrayecto.SelectedIndexChanged
        Dim idEmpresa = ddlCliente.SelectedValue
        Dim idRuta = ddlTrayecto.SelectedValue
        Dim listaCorreos = obtenerContactosSeguimiento(idEmpresa, idRuta)

        If listaCorreos.Length > 40 Then
            listaCorreos = String.Format("{0}...", listaCorreos.Substring(0, 40))
        Else
            listaCorreos = String.Format("{0}...", listaCorreos)
        End If
        lblContactos.Text = listaCorreos





    End Sub


    Protected Sub btnNuevoContacto_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevoContacto.Click
        If User.IsInRole("Facturacion") Then
            Return
        End If
        Session("id_empresa") = ddlCliente.SelectedValue
        cargarControlContactoSolicitud()
    End Sub




    Protected Sub ddlArrivo_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlArrivo.DataBound
        ddlArrivo.Items.Add(Crear_item("Seleccionar...", 0))

    End Sub


    Protected Sub lnkDestino_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkDestino.Click

        cargarControlArrivos()

    End Sub

    Protected Sub cargarControlArrivos()
        Session("arrivos") = 1
        Dim nuevoUsrCtl As UserControl = LoadControl("~/Controles_Usuario/ctlPuntosArrivo.ascx")
        PlaceHolder2.Controls.Add(nuevoUsrCtl)
        Panel1_ModalPopupExtender.Show()
    End Sub




    Protected Sub ddlTrayecto_DataBound(sender As Object, e As EventArgs) Handles ddlTrayecto.DataBound



    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

    End Sub
End Class