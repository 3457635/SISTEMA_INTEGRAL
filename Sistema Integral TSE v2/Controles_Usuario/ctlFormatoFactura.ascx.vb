Public Class ctlFormatoFactura
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ponerFecha()
        End If
    End Sub
    Public Sub limpiar_formulario()
        txbCiudad.Text = ""
        txbDireccion.Text = ""
        txbPrecioUnitario.Text = String.Empty
        txbDia.Text = ""
        txbMes.Text = ""
        txbAno.Text = ""
        txbIva.Text = ""
        txbNombre.Text = ""
        txbCantidad.Text = String.Empty
        txbDescripcion.Text = String.Empty
        txbImporte.Text = String.Empty

        txbCantidadLetra.Text = ""


        txbSubtotal.Text = ""

        txbRetencion.Text = ""
        txbRfc.Text = ""


        txbTelefono.Text = ""
        txbTotal.Text = ""
    End Sub
    Public Sub ponerFecha()
        Dim dia = Now.AddHours(-7).Day()
        Dim mes = Now.AddHours(-7).Month()
        Dim ano = Now.AddHours(-7).Year()

        txbDia.Text = dia.ToString()
        txbMes.Text = StrConv(Now.AddHours(-7).ToString("MMM"), VbStrConv.ProperCase)
        txbAno.Text = ano.ToString()

    End Sub
    Public Sub crearEncabezado(ByVal razonSocial As String,
                               ByVal direccion As String,
                               ByVal colonia As String,
                               ByVal estado As String,
                               ByVal CP As String,
                               ByVal ciudad As String,
                               ByVal rfc As String,
                               ByVal telefono As String
                               )

        txbNombre.Text = razonSocial
        txbRfc.Text = rfc
        txbTelefono.Text = telefono

        Dim _acomodar_colonia = acomodar_colonia(direccion, colonia, CP, ciudad, estado)

        If _acomodar_colonia = 0 Then
            txbDireccion.Text = String.Format("{0}, {1}", direccion, colonia)
            txbCiudad.Text = String.Format("{0}, {1}, {2}", ciudad, estado, CP)
        End If

        If _acomodar_colonia = 1 Then
            txbDireccion.Text = String.Format("{0}, COL.{1}", direccion, colonia)
            txbCiudad.Text = String.Format("{0}, {1}, {2}", ciudad, estado, CP)
        End If

        If _acomodar_colonia = 2 Then
            txbDireccion.Text = direccion
            txbCiudad.Text = String.Format("COL. {0}, {1}, {2}, {3}", colonia, ciudad, estado, CP)
        End If

    End Sub
    Public Function regresarTotal()
        Dim total = txbTotal.Text
        Return total
    End Function
    Public Function regresarRetencion()
        Dim retencion = txbRetencion.Text
        Return retencion
    End Function
    Public Function regresarIva()
        Dim iva = txbIva.Text
        Return iva
    End Function
    Public Function regresarSubtotal()
        Dim subtotal = txbSubtotal.Text
        Return subtotal
    End Function
    Public Sub agregarRenglon(ByVal cantidad As String,
                              ByVal descripcion As String,
                              ByVal precioUnitario As Decimal,
                              ByVal importe As Decimal
                              )

        txbCantidad.Text += cantidad + vbCrLf
        txbDescripcion.Text += String.Format("{0}{1}", descripcion, vbNewLine)
        txbPrecioUnitario.Text += String.Format("{0:c}{1}", precioUnitario, vbNewLine)
        txbImporte.Text += String.Format("{0:c}{1}", importe, vbNewLine)
        
    End Sub
    Public Function regresarCantidadPorLinea(ByVal numLinea As Integer)
        Dim cantidad = txbCantidad.Text
        Dim separadores() = {vbNewLine, " "}
        Dim arrayLineas = cantidad.Split(separadores, StringSplitOptions.RemoveEmptyEntries)
        Dim linea = String.Empty

        If numLinea < arrayLineas.Length Then
            linea = arrayLineas(numLinea)
        End If


        Return linea
    End Function
    Public Sub agregarAnotaciones(ByVal anotacion As String)
        txbAnotaciones.Text += anotacion
    End Sub
    Public Sub borrarAnotacion()
        txbAnotaciones.Text = String.Empty
    End Sub
    Public Sub cambiarLineaCantidad(ByVal numeroLinea As Integer,
                             ByVal cantidad As String
                              )

        Dim separadores() = {vbNewLine, " "}


        Dim campoCantidad() = txbCantidad.Text.Split(separadores, StringSplitOptions.RemoveEmptyEntries)

        txbCantidad.Text = String.Empty

        If campoCantidad.Length > 0 Then
            campoCantidad(numeroLinea) = cantidad
            For Each linea In campoCantidad
                txbCantidad.Text += linea + vbNewLine
            Next
        Else
            txbCantidad.Text = cantidad

        End If


    End Sub
    Public Sub cambiarLineaImporte(ByVal numeroLinea As Integer,
                             ByVal importe As String
                              )

        Dim separadores() = {vbNewLine, " "}

        Dim campoImporte() = txbImporte.Text.Split(separadores, StringSplitOptions.RemoveEmptyEntries)

        txbImporte.Text = String.Empty

        If campoImporte.Length > 0 Then
            campoImporte(numeroLinea) = importe
            For Each linea In campoImporte
                txbImporte.Text += String.Format("{0:c}{1}", CDec(linea), vbNewLine)
            Next
        Else
            txbImporte.Text = String.Format("{0:c}", importe)
        End If


    End Sub
    Public Sub calcularTotal(ByVal precioViaje As Decimal,
                             ByVal aplicaRetencion As Boolean,
                             ByVal facturaDolares As Boolean)
        Dim retencion As Decimal = 0
        Dim subtotal As Decimal = 0

        If IsNumeric(txbSubtotal.Text) Then
            subtotal = txbSubtotal.Text
        End If

        subtotal += precioViaje

        If aplicaRetencion Then
            retencion = subtotal * 0.04
        End If

        Dim iva = subtotal * 0.16
        Dim total = subtotal - retencion + iva

        txbSubtotal.Text = String.Format("{0:c}", subtotal)
        txbIva.Text = String.Format("{0:c}", iva)
        txbRetencion.Text = String.Format("{0:c}", retencion)
        txbTotal.Text = String.Format("{0:c}", total)

        Dim cantidad_letra As String = Letras(String.Format("{0:f2}", total), facturaDolares)
        txbCantidadLetra.Text = StrConv(cantidad_letra, VbStrConv.Uppercase)
    End Sub
End Class