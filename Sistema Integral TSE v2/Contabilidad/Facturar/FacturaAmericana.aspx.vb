Public Class FacturaAmericana
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim enDolares As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lnkSinFactura.Text = obtenerViajesSinFactura().ToString
            lblFolioA.Text = ctlFormatoFacturaAmericana1.obtenerFolio()
            ctlFormatoFacturaAmericana1.ponerFecha()
        End If


    End Sub

    Protected Sub ddlOrden_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlOrden.SelectedIndexChanged

    End Sub


    Protected Sub crear_factura(ByVal id_viaje As String)
        Dim monto = (From consulta In db.viajes, consulta2 In db.datos_facturacions, consulta3 In db.equipo_asignados, _
                     consulta4 In db.fechas_viajes
        Where (consulta.id_viaje = id_viaje And consulta.precio.empresa.id_empresa = consulta2.id_empresa _
               And consulta.id_viaje = consulta4.id_viaje And consulta4.fecha.tipo_fecha = 1 _
        And consulta.id_viaje = consulta3.ViajeId And consulta3.equipo_operacion.id_tipo_equipo <> 107)
           Select consulta.precio.precio,
           consulta2.razon_social,
           consulta2.calle,
           consulta2.colonia,
           consulta2.noExterior,
           consulta2.municipio,
           consulta2.estado,
           consulta2.c_postal,
           consulta2.telefono,
           consulta2.retencion,
           consulta4.fecha.fecha,
           consulta.Ordene.consecutivo,
           consulta.precio.llave_ruta.ruta,
           consulta3.equipo_operacion.tipo_equipo.equipo,
           consulta3.equipo_operacion.economico,
           consulta3.equipo_operacion.id_tipo_equipo,
           consulta.precio.factura_dolares,
consulta.precio.id_moneda).FirstOrDefault()

        Dim importe As Decimal = monto.precio
        enDolares = monto.factura_dolares

        Dim tipoVehiculo = String.Empty
        Dim Unidad = String.Empty
        Dim Orden = String.Empty
        Dim rutas = String.Empty

        If monto.id_tipo_equipo = 102 Then
            tipoVehiculo = "Trailer"

            Dim caja = (From consulta In db.cajaAsignadas
                     Where consulta.equipo_asignado.ViajeId = id_viaje
                     Select consulta.Caja.economico
                     ).FirstOrDefault()

            If Not caja Is Nothing Then
                Unidad = caja
            End If

        Else
            tipoVehiculo = monto.equipo
            Unidad = monto.economico
        End If


        Dim direccion = String.Format("{0} {1} {2}", monto.calle, monto.noExterior, monto.colonia)
        Dim city = String.Format("{0} {1} {2}", monto.municipio, monto.estado, monto.c_postal)

        ctlFormatoFacturaAmericana1.datosReceptor(monto.razon_social, direccion, city, String.Empty)

        Orden = "Orden: " + CStr(monto.consecutivo)
        rutas = "Ruta: " + monto.ruta


        Dim valorUnitario = importe

        Dim fecha_servicio As Date = monto.fecha
        Dim fechaServicio = "Servicio: " + fecha_servicio.ToString("dd/MM/yyyy")

        ctlFormatoFacturaAmericana1.agregarRenglon(1, String.Format("{0} / {1} {4} / {2} / {3}", Orden, tipoVehiculo, rutas, fechaServicio, Unidad), valorUnitario)

        Dim neto_string = CStr(importe)

        Dim cantidad_letra As String = Letras(String.Format("{0:f2}", CType(neto_string, Decimal)), monto.factura_dolares)
        ctlFormatoFacturaAmericana1.ponerCantidadConLetra(StrConv(cantidad_letra, VbStrConv.Uppercase))

        ctlFormatoFacturaAmericana1.obtenertotal()
    End Sub

    Protected Sub btnImprimir_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnImprimir.Click

        Dim folio = lblFolioA.Text
        Dim idViaje = ddlOrden.SelectedValue
        Dim importe = ctlFormatoFacturaAmericana1.obtenertotal()
        Dim idDatoFacturacion = ddlEmpresa.SelectedValue
        Dim enDolares = True

        Dim idFactura = nuevaFactura(folio, importe, idDatoFacturacion, True, 0, 0, importe, enDolares)

        If idFactura <> 0 Then

            Dim errorAlRegistrar = registrarViajeFacturacion(idViaje, idFactura)

            Dim orden = String.Empty

            Dim buscarOrden = (From consulta In db.viajes
                      Where consulta.id_viaje = idViaje
                      Select consulta).FirstOrDefault()

            If Not buscarOrden Is Nothing Then
                orden = buscarOrden.Ordene.ano.ToString() + "-" + buscarOrden.Ordene.consecutivo.ToString()
            End If

            If Not String.IsNullOrEmpty(errorAlRegistrar) Then
                lblMensaje.Text = "Ocurrió un error al registrar: " + errorAlRegistrar
            End If
            lblMensaje.Text = "Se imprimió la factura " + folio + " de la orden " + orden

            Response.Redirect("~/Contabilidad/Facturar/FacturaAmericana.aspx")
        Else
            lblMensaje.Text = "No se logró registrar la factura."

        End If
        Dim viajes_sin_factura = obtenerViajesSinFactura()
        lnkSinFactura.Text = viajes_sin_factura.ToString()


    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkCancelarOrden.Click
        btnImprimir.Enabled = True
        Dim idViaje = ddlOrden.SelectedValue
        cancelarFactura(idViaje)

        lblMensaje.Text = String.Format("Se canceló la factura . Ahora puede imprimir la nueva factura.")
        lnkCancelarOrden.Visible = False

    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        Dim datos_facturacion = (From consulta In db.datos_facturacions
                             Where consulta.id_dato = ddlEmpresa.SelectedValue
                             Select consulta).FirstOrDefault()
        If Not datos_facturacion Is Nothing Then
            Dim calle = datos_facturacion.calle
            Dim colonia = datos_facturacion.colonia
            Dim numero = datos_facturacion.noExterior

            Dim ciudad = datos_facturacion.municipio
            Dim estado = datos_facturacion.estado
            Dim cp = datos_facturacion.c_postal

            Dim direccion = String.Format("{0} {1}, {2}", calle, numero, colonia)
            Dim city = String.Format("{0}, {1}. {2}", ciudad, estado, cp)

            ctlFormatoFacturaAmericana1.datosReceptor(datos_facturacion.razon_social, direccion, city, String.Empty)

        End If

    End Sub



    Protected Sub lnkSinFactura_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkSinFactura.Click
        Response.Redirect("~/Contabilidad/SinFactura_detalle.aspx")
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim folio = lblFolioA.Text
        Dim idViaje = ddlOrden.SelectedValue
        Dim idDatoFacturacion = ddlEmpresa.SelectedValue
        ctlFormatoFacturaAmericana1.limpiarFormulario()

        If Not String.IsNullOrEmpty(folio) Then

            lblMensaje.Text = String.Empty
            Dim repetida = factura_utilizada_anteriormente(folio, idViaje) ''MiLibreria.vb

            If repetida <> "" Then
                btnImprimir.Enabled = False
                lblMensaje.Text = "Esta factura no puede registrarse porque ya fue utilizada en el servicio " + repetida
            Else
                btnImprimir.Enabled = True


                Dim factura_anterior = orden_facturada_anteriormente(idViaje, folio, idDatoFacturacion) ''MiLibreria.vb

                If factura_anterior <> "" Then
                    btnImprimir.Enabled = False
                    lnkCancelarOrden.Visible = True
                    lblMensaje.Text = "Este viaje tiene la factura " + factura_anterior
                Else

                    If Not String.IsNullOrEmpty(lblFolioA.Text) Then
                        folio = lblFolioA.Text
                    End If
                    limpiar_formulario(form1)
                    lblFolioA.Text = folio

                    btnImprimir.Enabled = True
                    crear_factura(idViaje)



                End If

            End If
        Else
            lblMensaje.Text = "Primero debe ingresar el numero de factura."

        End If
    End Sub

    Protected Sub btnNueva_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNueva.Click
        Response.Redirect("~/Contabilidad/Facturar/FacturaAmericana.aspx")
    End Sub
End Class