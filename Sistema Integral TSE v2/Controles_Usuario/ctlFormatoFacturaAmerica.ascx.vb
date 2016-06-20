Public Class ctlFormatoFacturaAmerica
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

        txbNombre.Text = ""
        txbCantidad.Text = String.Empty
        txbDescripcion.Text = String.Empty
        txbImporte.Text = String.Empty

        txbCantidadLetra.Text = ""

        txbRfc.Text = ""


        txbTelefono.Text = ""
        txbTotal.Text = ""
    End Sub
    Public Sub ponerFecha()
        txbDia.Text = StrConv(Now.AddHours(-7).ToString("MMM"), VbStrConv.ProperCase)
        txbMes.Text = Now.AddHours(-7).Day.ToString()
        txbAno.Text = Now.AddHours(-7).Year.ToString()

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

        
        txbDireccion.Text = String.Format("{0}, {1}", direccion, colonia)
        txbCiudad.Text = String.Format("{0}, {1} {2}", ciudad, estado, CP)
        
           

    End Sub
    Public Function regresarTotal()
        Dim total = txbTotal.Text
        Return total
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
    Public Sub ingresarTotal(ByVal total As Decimal)

        txbTotal.Text = String.Format("{0:c}", total)

        Dim cantidad_letra As String = Letras(String.Format("{0:f2}", total), True)
        txbCantidadLetra.Text = StrConv(cantidad_letra, VbStrConv.Uppercase)
    End Sub
End Class