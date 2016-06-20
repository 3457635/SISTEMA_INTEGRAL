Imports DGMC.TimbraCFDI
Imports iTextSharp
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html.simpleparser
Imports System.IO
Public Class ctlFormatoCFDI
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses2DataContext()
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
        lblMensajeCBB.Text = String.Empty
        lblMensajeCFDI.Text = String.Empty
        lblMensajePdf.Text = String.Empty

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
                              ByVal colonia As String,
                              ByVal estado As String,
                              ByVal CP As String,
                              ByVal ciudad As String,
                              ByVal rfc As String,
                              ByVal telefono As String,
                              ByVal calle As String,
                              ByVal noExterior As String
                              )

        txbNombre.Text = razonSocial
        txbRfc.Text = rfc
        txbTelefono.Text = telefono

        Dim direccion = String.Format("{0} No.{1}", calle, noExterior)


        Dim _acomodar_colonia = acomodar_colonia(direccion, colonia, CP, ciudad, estado)

        If _acomodar_colonia = 0 Then
            txbDireccion.Text = direccion
            txbCiudad.Text = ""
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
    Public Function regresarDescripcion()
        Dim descripcion = txbDescripcion.Text
        Return descripcion
    End Function
    Public Function regresarimporte()
        Dim importe = txbImporte.Text
        Return importe
    End Function
    Public Function regresarPrecioUnitario()
        Dim precioUnitario = txbPrecioUnitario.Text
        Return precioUnitario
    End Function
    Public Sub agregarRenglon(ByVal cantidad As String,
                              ByVal descripcion As String,
                              ByVal precioUnitario As Decimal,
                              ByVal importe As Decimal
                              )

        txbCantidad.Text += cantidad + vbCrLf
        txbDescripcion.Text += String.Format("{0}{1}", descripcion, vbNewLine)
        txbPrecioUnitario.Text += String.Format("{0:c2}{1}", precioUnitario, vbNewLine)
        txbImporte.Text += String.Format("{0:c2}{1}", importe, vbNewLine)

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
                txbImporte.Text += String.Format("{0:c2}{1}", CDec(linea), vbNewLine)
            Next
        Else
            txbImporte.Text = String.Format("{0:c2}", importe)
        End If


    End Sub
    Public Sub calcularTotal(ByVal precioViaje As Decimal,
                             ByVal aplicaRetencion As Boolean,
                             ByVal facturaDolares As Boolean,
                             Optional ByVal tasaIva As Integer = 16)

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

        If tasaIva = 0 Then
            iva = 0.0
        End If

        Dim total = subtotal - retencion + iva

        txbSubtotal.Text = String.Format("{0:c2}", subtotal)
        txbIva.Text = String.Format("{0:c2}", iva)
        txbRetencion.Text = String.Format("{0:c2}", retencion)
        txbTotal.Text = String.Format("{0:c2}", total)

        Dim cantidad_letra As String = Letras(String.Format("{0:f2}", total), facturaDolares)
        txbCantidadLetra.Text = StrConv(cantidad_letra, VbStrConv.Uppercase)
    End Sub

    'Public Function generaCFDI(ByVal comprobante As Comprobante) As ResultadoTimbre
    '    'Este ejemplo está dirigido a aquellos integradores que aún no generan el xml (CFDI)

    '    'Inicializamos el conector' el parámetro indica el ambiente en el que se utilizará 
    '    'Fasle = Ambiente de pruebas
    '    'True = Ambiente de producción
    '    Dim conector As New Conector(True)

    '    'Establecemos las credenciales para el permiso de conexión
    '    'Ambiente de pruebas = mvpNUXmQfK8=
    '    'Ambiente de producción = Esta será asignado por el proveedor al salir a productivo

    '    'Produccion
    '    conector.EstableceCredenciales("jsy+7kNPsnOotlnstxiE6w==")

    '    'Prueba
    '    'conector.EstableceCredenciales("mvpNUXmQfK8=")

    '    'Timbramos el CFDI por medio del conector y guardamos resultado'
    '    Dim resultadoTimbre As ResultadoTimbre
    '    resultadoTimbre = conector.TimbraCFDI(comprobante)

    '    'Verificamos el resultado
    '    If (resultadoTimbre.Exitoso) Then

    '        'El comprobante fue timbrado exitosamente
    '        Dim exitoXML = True
    '        Dim exitoCBB = True


    '        'Guardamos xml cfdi
    '        If (resultadoTimbre.GuardaXml(Server.MapPath("~/Contabilidad/Facturar/xmls"), String.Format("{0}-{1}", comprobante.serie, comprobante.folio))) Then
    '            lblMensajeCFDI.Text = "El xml fue guardado correctamente."
    '        Else
    '            lblMensajeCFDI.Text = "Ocurrió un error al guardar el comprobante."
    '            exitoXML = False
    '        End If

    '        'Los siguientes datos deberán ir en la respresentación impresa ó PDF

    '        '1.- Código bidimensional
    '        If (resultadoTimbre.GuardaCodigoBidimensional(Server.MapPath("~/Contabilidad/Facturar/codigos"), String.Format("{0}-{1}", comprobante.serie, comprobante.folio))) Then
    '            lblMensajeCBB.Text = "El código bidimensional fue guardado correctamente."
    '        Else
    '            lblMensajeCBB.Text = "Ocurrió un error al guardar el código bidimensional."
    '            exitoCBB = False
    '        End If

    '        '2.- Folio fiscal
    '        Dim foliFiscal As String = resultadoTimbre.FolioUUID

    '        '3.- No. Certificado del Emisor
    '        Dim noCertificado As String = resultadoTimbre.No_Certificado

    '        '4.- No. Certificado del SAT
    '        Dim noCertificadoSat As String = resultadoTimbre.No_Certificado_SAT

    '        '5.- Fecha y Hora de certificación
    '        Dim fechaCert As String = resultadoTimbre.FechaCertificacion

    '        '6.- Sello del cfdi
    '        Dim selloCFDI As String = resultadoTimbre.SelloCFDI

    '        '7.- Sello del SAT
    '        Dim selloSAT As String = resultadoTimbre.SelloSAT

    '        '8.- Cadena original de complemento de certificación
    '        Dim cadena As String = resultadoTimbre.CadenaTimbre

    '        If Not exitoCBB Or Not exitoXML Then
    '            resultadoTimbre = Nothing
    '        End If
    '    Else
    '        lblMensajeCFDI.Text = resultadoTimbre.Descripcion
    '        resultadoTimbre = Nothing
    '    End If
    '    Return resultadoTimbre
    'End Function
    Public Function generaCFDI(ByVal comprobante As Comprobante) As TSE.Timbrado.ResultadoTimbre
        'Este ejemplo está dirigido a aquellos integradores que aún no generan el xml (CFDI)

        'Inicializamos el conector' el parámetro indica el ambiente en el que se utilizará 
        'Fasle = Ambiente de pruebas
        'True = Ambiente de producción
        Dim conector As New TSE.Timbrado.Conector(True)


        'Timbramos el CFDI por medio del conector y guardamos resultado'
        Dim resultadoTimbre = conector.TimbrarCFDI(comprobante)

        'Verificamos el resultado
        If (resultadoTimbre.Exitoso) Then

            'El comprobante fue timbrado exitosamente
            Dim exitoXML = True
            Dim exitoCBB = True


            'Guardamos xml cfdi
            If (resultadoTimbre.GuardaXml(Server.MapPath("~/Contabilidad/Facturar/xmls"), String.Format("{0}-{1}", comprobante.serie, comprobante.folio))) Then
                lblMensajeCFDI.Text = "El xml fue guardado correctamente."
            Else
                lblMensajeCFDI.Text = "Ocurrió un error al guardar el comprobante."
                exitoXML = False
            End If

            'Los siguientes datos deberán ir en la respresentación impresa ó PDF

            '1.- Código bidimensional
            If (resultadoTimbre.GuardaCodigoBidimensional(Server.MapPath("~/Contabilidad/Facturar/codigos"), String.Format("{0}-{1}", comprobante.serie, comprobante.folio))) Then
                lblMensajeCBB.Text = "El código bidimensional fue guardado correctamente."
            Else
                lblMensajeCBB.Text = "Ocurrió un error al guardar el código bidimensional."
                exitoCBB = False
            End If

            '2.- Folio fiscal
            Dim foliFiscal As String = resultadoTimbre.FolioUUID

            '3.- No. Certificado del Emisor
            Dim noCertificado As String = resultadoTimbre.No_Certificado

            '4.- No. Certificado del SAT
            Dim noCertificadoSat As String = resultadoTimbre.No_Certificado_SAT

            '5.- Fecha y Hora de certificación
            Dim fechaCert As String = resultadoTimbre.FechaCertificacion

            '6.- Sello del cfdi
            Dim selloCFDI As String = resultadoTimbre.SelloCFDI

            '7.- Sello del SAT
            Dim selloSAT As String = resultadoTimbre.SelloSAT

            '8.- Cadena original de complemento de certificación
            Dim cadena As String = resultadoTimbre.CadenaTimbre

            If Not exitoCBB Or Not exitoXML Then
                resultadoTimbre = Nothing
            End If
        Else
            lblMensajeCFDI.Text = resultadoTimbre.Descripcion
            resultadoTimbre = Nothing
        End If
        Return resultadoTimbre
    End Function
    'Public Function generarPdf(ByVal comprobante As Comprobante,
    '                      ByVal ResultadoTimbre As ResultadoTimbre,
    '                      ByVal facturadaEnDolares As Boolean,
    '                      ByVal aplicaRetencion As Boolean,
    '                      Optional ByVal tasaIva As Integer = 16)
    Public Function generarPdf(ByVal comprobante As Comprobante,
                          ByVal ResultadoTimbre As TSE.Timbrado.ResultadoTimbre,
                          ByVal facturadaEnDolares As Boolean,
                          ByVal aplicaRetencion As Boolean,
                          Optional ByVal tasaIva As Integer = 16)

        'Manual http://www.4guysfromrolla.com/articles/030911-1.aspx
        'Codigo de ejemplo http://www.4guysfromrolla.com/code/PdfCreate.pdf

        Dim itemsTable As String = String.Empty
        Dim subtotal As Decimal = 0.0

        Dim exito = True

        Dim iva = 0.0F
        Dim retencion = 0.0F
        Dim total = 0.0F

        Dim document = New Document(PageSize.LETTER, 15, 15, 15, 15)

        Try
            PdfWriter.GetInstance(document, New FileStream(Server.MapPath(String.Format("~/contabilidad/facturar/pdfs/{0}-{1}.pdf", comprobante.serie, comprobante.folio)), FileMode.Create))
            document.Open()

            'Ejemplo para agregar tablas'
            'Dim tablaTimbrado As Table = New Table(2)
            'tablaTimbrado.AddCell("CANTIDAD")
            'tablaTimbrado.AddCell("UNIDAD DE MEDIDA")
            'tablaTimbrado.AddCell("DESCRIPCIÓN")
            'tablaTimbrado.AddCell("PRECIO UNITARIO")
            'tablaTimbrado.AddCell("IMPORTE")

            itemsTable = "<TABLE><TR><TH>CANTIDAD</TH> <TH>UNIDAD DE MEDIDA</TH> <th>DESCRIPCIÓN</TH> <TH>PRECIO UNITARIO</TH> <TH>IMPORTE</TH> </TR>"
            For Each Concepto In comprobante.Conceptos

                'Dim cellCantidad As Cell = New Cell(Concepto.cantidad.ToString())
                'cellCantidad.SetWidth("10")
                'tablaTimbrado.AddCell(cellCantidad)

                'Dim cellUnidad As Cell = New Cell(Concepto.unidad)
                'cellUnidad.SetWidth("10")
                'tablaTimbrado.AddCell(cellUnidad)

                'Dim cellDescripcion As Cell = New Cell(Concepto.descripcion)
                'cellDescripcion.SetWidth("10")
                'tablaTimbrado.AddCell(cellDescripcion)

                'Dim cellPUnitario As Cell = New Cell(Concepto.valorUnitario.ToString())
                'cellPUnitario.SetWidth("10")
                'tablaTimbrado.AddCell(cellPUnitario)

                'Dim cellImporte As Cell = New Cell(Concepto.importe.ToString())
                'cellImporte.SetWidth("10")
                'tablaTimbrado.AddCell(cellImporte)

                itemsTable += String.Format("<TR><TD width='15'>{0}</TD><TD width='15'>{1}</TD><TD width='80'>{2}</TD><TD>{3:c2}</TD><TD width='15'>{4:c2}</TD></TR>", Concepto.cantidad, Concepto.unidad, Concepto.descripcion, Concepto.valorUnitario, Concepto.importe)
                subtotal += Concepto.importe
            Next

            iva = subtotal * 0.16
            If tasaIva = 0 Then
                iva = 0.0
            End If

            If aplicaRetencion Then
                retencion = subtotal * 0.04
            End If
            total = subtotal - retencion + iva

            itemsTable += String.Format("<TR><TD></TD><TD></TD><TD></TD><TD><strong>Subtotal</strong></TD><TD><strong>{0:c2}</strong></TD></TR>", subtotal)
            itemsTable += String.Format("<TR><TD></TD><TD></TD><TD></TD><TD><strong>IVA</strong></TD><TD><strong>{0:c2}</strong></TD></TR>", iva)
            itemsTable += String.Format("<TR><TD></TD><TD></TD><TD></TD><TD><strong>Retención</strong></TD><TD><strong>{0:c2}</strong></TD></TR>", retencion)
            itemsTable += String.Format("<TR><TD></TD><TD></TD><TD></TD><TD><strong>Total</strong></TD><TD><strong>{0:c2}</strong></TD></TR>", total)
            itemsTable += "</TABLE>"

            'Contenido
            'Dim parrafo = New Paragraph("Hola")
            'document.Add(parrafo)
            Dim logo = iTextSharp.text.Image.GetInstance(Server.MapPath(("~/Imagenes/logoFactura.jpg")))
            'logo.SetAbsolutePosition(380, 690)
            logo.Alignment = Image.TEXTWRAP
            logo.IndentationRight = 30.0F
            document.Add(logo)

            Dim contents As String = File.ReadAllText(Server.MapPath("~/contabilidad/facturar/factura.htm"))
            contents = contents.Replace("[folio]", comprobante.folio)
            contents = contents.Replace("[serie]", comprobante.serie)
            contents = contents.Replace("[folioFiscal]", ResultadoTimbre.FolioUUID)
            contents = contents.Replace("[certificado]", ResultadoTimbre.No_Certificado)
            contents = contents.Replace("[lugar]", String.Format("{0},{1},{2}.", comprobante.Emisor.DomicilioFiscal.pais, comprobante.Emisor.DomicilioFiscal.estado, comprobante.Emisor.DomicilioFiscal.municipio))
            contents = contents.Replace("[fechaEmision]", comprobante.fecha)
            contents = contents.Replace("[regimen]", comprobante.Emisor.RegimenFiscal(0).Regimen)

            contents = contents.Replace("[emisorNombre]", comprobante.Emisor.nombre)
            Dim direccionEmisor = String.Format("{0} No.{1}, {2}. {3}, {4}", comprobante.Emisor.DomicilioFiscal.calle, comprobante.Emisor.DomicilioFiscal.noExterior, comprobante.Emisor.DomicilioFiscal.colonia, comprobante.Emisor.DomicilioFiscal.municipio, comprobante.Emisor.DomicilioFiscal.estado)
            contents = contents.Replace("[emisorDireccion]", direccionEmisor)
            contents = contents.Replace("[emisorCp]", comprobante.Emisor.DomicilioFiscal.codigoPostal)
            contents = contents.Replace("[paginaWeb]", "tse.com.mx")
            contents = contents.Replace("[rfcEmisor]", comprobante.Emisor.rfc)

            contents = contents.Replace("[nombreReceptor]", comprobante.Receptor.nombre)
            contents = contents.Replace("[rfcReceptor]", comprobante.Receptor.rfc)
            Dim direccionReceptor = String.Format("{0} No. {1}, {2}. {3}, {4}. {5}", comprobante.Receptor.Domicilio.calle, comprobante.Receptor.Domicilio.noExterior, comprobante.Receptor.Domicilio.colonia, comprobante.Receptor.Domicilio.municipio, comprobante.Receptor.Domicilio.estado, comprobante.Receptor.Domicilio.codigoPostal)
            contents = contents.Replace("[domicilioReceptor]", direccionReceptor)

            Dim cantidadEnLetra = StrConv(Letras(String.Format("{0:f2}", comprobante.total), facturadaEnDolares), VbStrConv.Uppercase)

            'document.Add(tablaTimbrado)
            Dim cantidad = String.Empty
            contents = contents.Replace("[ITEMS]", itemsTable)
            contents = contents.Replace("[cantidadEnLetra]", cantidadEnLetra)
            contents = contents.Replace("[formaDePago]", comprobante.formaDePago)
            contents = contents.Replace("[metodoDePago]", comprobante.metodoDePago)

            If Not String.IsNullOrEmpty(comprobante.NumCtaPago) Then
                contents = contents.Replace("[ctaDePago]", String.Format("No.Cta. Pago: {0}", comprobante.NumCtaPago))
            Else
                contents = contents.Replace("[ctaDePago]", "No. Cta. Pago: No Identificado")
            End If


            Dim colorVerde = New Color(0, 66, 0)
            Dim sizeFont = 7.0F
            Dim titleFont = FontFactory.GetFont("Arial", sizeFont, Font.BOLDITALIC, colorVerde)
            Dim paraghapFont = FontFactory.GetFont("Arial", sizeFont, Color.BLACK)


            Dim e1 As New Chunk("Sello Digital del CFDI:" + vbNewLine, titleFont)
            Dim e2 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.SelloCFDI, vbNewLine), paraghapFont)
            Dim e3 As New Chunk("Sello del SAT:" + vbNewLine, titleFont)
            Dim e4 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.SelloSAT, vbNewLine), paraghapFont)
            Dim parrafo As New Paragraph()
            parrafo.Add(e1)
            parrafo.Add(e2)
            parrafo.Add(e3)
            parrafo.Add(e4)

            Dim e5 As New Chunk("Cadena original del complemento de certificacion digital del SAT:" + vbNewLine, titleFont)
            Dim e6 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.CadenaTimbre, vbNewLine), paraghapFont)
            Dim e7 As New Chunk("No de Serie del Certificado del SAT:" + vbNewLine, titleFont)
            Dim e8 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.SelloSAT, vbNewLine), paraghapFont)
            Dim e9 As New Chunk("Fecha y Hora de Certificación:" + vbNewLine, titleFont)
            Dim e10 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.FechaCertificacion, vbNewLine), paraghapFont)
            Dim e11 As New Chunk("Este documento es una representación impresa de un CFDI", paraghapFont)
            Dim parrafo2 As New Paragraph()
            parrafo2.Add(e5)
            parrafo2.Add(e6)
            parrafo2.Add(e7)
            parrafo2.Add(e8)
            parrafo2.Add(e9)
            parrafo2.Add(e10)
            parrafo2.Add(e11)

            Dim parsedHtmlElements = HTMLWorker.ParseToList(New StringReader(contents), Nothing)

            For Each htmlElement In parsedHtmlElements
                document.Add(htmlElement)
            Next

            Dim codigo = iTextSharp.text.Image.GetInstance(Server.MapPath(String.Format("~/contabilidad/facturar/codigos/{0}-{1}.jpg", comprobante.serie, comprobante.folio)))
            codigo.ScalePercent(50, 50)
            codigo.Alignment = Image.TEXTWRAP ''Insertar imagen con texto
            codigo.SpacingAfter = 15.0F
            codigo.IndentationRight = 30.0F
            document.Add(codigo)
            document.Add(parrafo)
            document.Add(parrafo2)
            document.Close()



            'Para abrir el pdf en una ventana nueva
            'Response.ContentType = "application/pdf"
            'Response.AddHeader("Content-Disposition", String.Format("attachment;filename=Receipt-{0}.pdf", "Orden"))
            'Response.BinaryWrite(output.ToArray())
        Catch ex As Exception
            lblMensajePdf.Text = String.Format("Ocurrio un problema al guardar el archivo pdf.{0}", ex.Message)
            Return False
        Finally
            document.Close()
        End Try
        Return exito
    End Function


End Class