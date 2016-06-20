Imports System.Xml
Imports System.Web.HttpServerUtility
Imports iTextSharp
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html.simpleparser
Imports System.IO
Imports System.IO.MemoryStream


Public Class factura
    Public Property version As String = "3.2"
    Public Property serie As String = "NV"
    Public Property fecha As Date
    Public Property folioFactura As Integer = 9
    Public Property sello As String
    Public Property formaPago As String = "Pago en una sola exhibición"
    Public Property noCertificado As String
    Public Property certificado As String
    Public Property subtotal As Double
    'Opcional'
    Public Property descuento As Double = 0.0
    'Opcional'
    Public Property tipoCambio As Double
    'Opcional'
    Public Property moneda As String
    Public Property facturaTotal As Double
    Public Property tipoDeComprobante As String = "ingreso"
    Public Property metodoDePago As String = "No identificado"
    Public Property lugarExpedicion As String = "Mexico"

    'Emisor'
    Public Property emisorRfc As String = "CALL630921V68"
    Public Property emisorNombre As String = "Luis Carlos Chavez Loya"

    'Domicilio Fiscal Emisor'
    Public Property domicilioFiscalCalle As String = "Av.Octavio Paz"
    Public Property domicilioFiscalnoExterior As String = "170"
    Public Property domicilioFiscalColonia As String = "Complejo Industrial Chihuahua"
    Public Property domicilioFiscalMunicipio As String = "Chihuahua"
    Public Property domicilioFiscalEstado As String = "Chihuahua"
    Public Property domicilioFiscalPais As String = "Mexico"
    Public Property domicilioFiscalCodigoPostal As String = "31109"

    'Regimen Fiscal emisor'
    Public Property regimen As String = "Local"

    'Receptor'
    Public Property receptorRfc As String
    Public Property receptorNombre As String
    Public Property receptorCalle As String
    Public Property receptorNoExterior As String
    Public Property receptorColonia As String
    Public Property receptorLocalidad As String
    Public Property receptorEstado As String
    Public Property receptorPais As String
    Public Property receptorCodigoPostal As String

    'Impuestos'
    Public Property IvaTasa As Double = 16.0
    Public Property IvaImporte As Decimal
    Public Property IvaImpuesto As String = "IVA"

    Public Property RetencionTasa As Double = 4.0
    Public Property RetencionImporte As Decimal
    Public Property RetencionImpuesto As String = "Retencion"

    Public Property totalImpuestosTraslados As Double

    Public Function timbrar(ByVal rutaArchivoXML As String) As String

        '//Hacer referencia al servicio web de pruebas de timbrado, que se encuentra en la siguiente URL
        '//'http://74.81.83.152/ServicioIntegracionPruebas/Timbrado.asmx

        '//En este ejemplo la referencia al servicio web de timbrado será identificada como 'ServicioIntegracionReference'
        '//
        '//El servicio para timbrado funciona de la siguiente manera
        '//
        '//Se reciben 3 parámetros
        '//
        '//Usuario Integrador (Especificar el usuario integrador asignado, para efecto de pruebas se utilizará el usuario 'mvpNUXmQfK8=')
        '//Xml (El archivo xml a timbrar en base64)
        '//IdComprobante (Un identificador único para el timbrado de cada comprobante)

        '//Parametros
        Dim usuarioIntegrador As String = "mvpNUXmQfK8="
        Dim comprobanteBase64 As String = Convert.ToBase64String(System.IO.File.ReadAllBytes(rutaArchivoXML))
        '//Para efecto de pruebas se utilizará un número aleatorio
        Dim miRandom As New Random()
        Dim idComprobante As String = "343436" 'miRandom.Next(0, 999999).ToString()

        '//Llamamos al web method Registra Emisor
        Dim soapClient As ServicioIntegracionReference.TimbradoSoapClient = New ServicioIntegracionReference.TimbradoSoapClient()
        Dim resultados As ServicioIntegracionReference.ArrayOfAnyType
        resultados = soapClient.TimbraCFDI(usuarioIntegrador, comprobanteBase64, idComprobante)

        '//Obtenemos datos del registro

        '//Tipo de excepcion
        Dim tipoExcepcion As String = resultados(0).ToString()
        '//Numero de error
        Dim numeroError As String = resultados(1).ToString()
        '//Descripcion del resultado
        Dim descripcion As String = resultados(2).ToString()

        '////Xml timbrado
        Dim xml As String = resultados(3).ToString()
        '//Codigo bidimensional
        Dim codigoBidimensionalBytes() As Byte = resultados(4)
        '//Cadena timbre
        Dim cadenaTimbre As String = resultados(5).ToString()

        '//Vefificamos que el resultado haya sido exitoso
        If (numeroError = "0") Then

            Return "El comprobante fue timbrado exitosamente"

        Else

            '//Ocurrió un error en el timbrado
            Return descripcion

        End If
    End Function

    Public Sub crearXml(ByVal writer As XmlWriter, ByVal ParamArray conceptoArreglo() As Conceptos)

        Try
            ' Create the XmlWriter object and write some content.
            writer.WriteStartElement("cfdi", "Comprobante", "http://www.sat.gob.mx/cfd/3")
            writer.WriteAttributeString("xmlns", "xsi", Nothing, "http://www.w3.org/2001/XMLSchema-instance")
            writer.WriteAttributeString("xmlns", "detallista", Nothing, "http://www.sat.gob.mx/detallista")
            writer.WriteAttributeString("xmlns", "implocal", Nothing, "http://www.sat.gob.mx/implocal")
            writer.WriteAttributeString("xmlns", "donat", Nothing, "http://www.sat.gob.mx/donat")
            writer.WriteAttributeString("xsi", "schemaLocation", Nothing, "http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd http://www.sat.gob.mx/implocal http://www.sat.gob.mx/sitio_internet/cfd/implocal/implocal.xsd http://www.sat.gob.mx/detallista http://www.sat.gob.mx/sitio_internet/cfd/detallista/detallista.xsd http://www.sat.gob.mx/donat http://www.sat.gob.mx/sitio_internet/cfd/donat/donat11.xsd")
            writer.WriteAttributeString("version", Me.version)
            writer.WriteAttributeString("serie", Me.serie)
            writer.WriteAttributeString("folio", Me.folioFactura)
            writer.WriteAttributeString("fecha", Me.fecha)
            writer.WriteAttributeString("sello", Me.sello)
            writer.WriteAttributeString("formaDePago", Me.formaPago)
            writer.WriteAttributeString("noCertificado", Me.noCertificado)
            writer.WriteAttributeString("certificado", Me.certificado)
            writer.WriteAttributeString("subtotal", Me.subtotal)
            writer.WriteAttributeString("descuento", Me.descuento)
            writer.WriteAttributeString("tipoCambio", Me.tipoCambio)
            writer.WriteAttributeString("Moneda", Me.moneda)
            writer.WriteAttributeString("total", Me.facturaTotal)
            writer.WriteAttributeString("tipoDeComprobante", Me.tipoDeComprobante)
            writer.WriteAttributeString("metodoDePago", Me.metodoDePago)
            writer.WriteAttributeString("LugarExpedicion", Me.lugarExpedicion)

            ''Fin atributos cfdi
            writer.WriteStartElement("cfdi", "Emisor", "http://www.sat.gob.mx/cfd/3")
            writer.WriteAttributeString("rfc", Me.emisorRfc)
            writer.WriteAttributeString("nombre", Me.emisorNombre)
            writer.WriteStartElement("cfdi", "DomicilioFiscal", "http://www.sat.gob.mx/cfd/3")
            writer.WriteAttributeString("calle", Me.domicilioFiscalCalle)
            writer.WriteAttributeString("municipio", Me.domicilioFiscalMunicipio)
            writer.WriteAttributeString("estado", Me.domicilioFiscalEstado)
            writer.WriteAttributeString("pais", Me.domicilioFiscalPais)
            writer.WriteAttributeString("codigoPostal", Me.domicilioFiscalCodigoPostal)
            writer.WriteEndElement()
            writer.WriteEndElement()
            ''Fin atributos emisor
            writer.WriteStartElement("Receptor", "http://www.sat.gob.mx/cfd/3")
            writer.WriteStartAttribute("rfc", Me.receptorRfc)
            writer.WriteStartAttribute("nombre", Me.receptorNombre)
            writer.WriteStartElement("Domicilio", "http://www.sat.gob.mx/cfd/3")
            writer.WriteStartAttribute("calle", Me.receptorCalle)
            writer.WriteStartAttribute("noExterior", Me.receptorNoExterior)
            writer.WriteStartAttribute("colonia", Me.receptorColonia)
            writer.WriteStartAttribute("localidad", Me.receptorLocalidad)
            writer.WriteStartAttribute("estado", Me.receptorEstado)
            writer.WriteStartAttribute("pais", Me.receptorPais)
            writer.WriteStartAttribute("codigoPostal", Me.receptorCodigoPostal)
            writer.WriteEndElement()
            writer.WriteEndElement()
            'Fin atributos receptor
            writer.WriteStartElement("conceptos")
            For Each concepto In conceptoArreglo
                writer.WriteStartElement("cfdi", "concepto", "http://www.sat.gob.mx/cfd/3")
                writer.WriteStartAttribute("cantidad")
                writer.WriteValue(concepto.cantidad)
                writer.WriteStartAttribute("unidad")
                writer.WriteValue(concepto.unidad)
                writer.WriteStartAttribute("descripcion")
                writer.WriteValue(concepto.descripcion)
                writer.WriteStartAttribute("valorUnitario")
                writer.WriteValue(concepto.valorUnitario)
                writer.WriteStartAttribute("importe")
                writer.WriteValue(concepto.importe)

                writer.WriteEndElement()
            Next
            writer.WriteEndElement()
            'Fin conceptos
            writer.WriteStartElement("cfdi", "impuestos", "http://www.sat.gob.mx/cfd/3")
            writer.WriteStartAttribute("totalImpuestosTraslados")
            writer.WriteValue(Me.totalImpuestosTraslados)
            writer.WriteStartElement("traslados", "http://www.sat.gob.mx/cfd/3")
            writer.WriteStartElement("traslado", "http://www.sat.gob.mx/cfd/3")
            writer.WriteStartAttribute("impuesto")
            writer.WriteValue(Me.IvaImpuesto)
            writer.WriteStartAttribute("tasa")
            writer.WriteValue(Me.IvaTasa)
            writer.WriteStartAttribute("importe")
            writer.WriteValue(Me.IvaImporte)
            writer.WriteEndElement()
            ''Fin traslado
            writer.WriteEndElement()
            ''Fin traslados
            writer.WriteEndElement()
            ''Fin impuestos
            writer.Flush()

        Finally
            If Not (writer Is Nothing) Then
                writer.Close()
            End If
        End Try
    End Sub
    Public Sub crearPdf(ByVal contents As String, ByVal logo As iTextSharp.text.Image, ByVal document As iTextSharp.text.Document)

        'Manual http://www.4guysfromrolla.com/articles/030911-1.aspx
        'Codigo de ejemplo http://www.4guysfromrolla.com/code/PdfCreate.pdf


        document.Open()

        'Contenido
        'Dim parrafo = New Paragraph("Hola")
        'document.Add(parrafo)

        contents = contents.Replace("[folioFiscal]", "Orden")
        contents = contents.Replace("[certificado]", "Precio")
        contents = contents.Replace("[lugar]", "fecha")

        Dim itemsTable = "<TABLE><TR><TH>CANTIDAD</TH> <TH>UNIDAD DE MEDIDA</TH> <th>DESCRIPCIÓN</TH> <TH>PRECIO UNITARIO</TH> <TH>IMPORTE</TH> </TR>"
        For i = 0 To 7 Step 1
            itemsTable += "<TR><TD>1</TD><TD>NA</TD><TD>Flete</TD><TD>2000.00</TD><TD>2000.00</TD></TR>"
        Next
        itemsTable += "<TR><TD></TD><TD></TD><TD></TD><TD><strong>Subtotal</strong></TD><TD><strong>2000.00</strong></TD></TR>"
        itemsTable += "<TR><TD></TD><TD></TD><TD></TD><TD><strong>IVA</strong></TD><TD><strong>320.00</strong></TD></TR>"
        itemsTable += "<TR><TD></TD><TD></TD><TD></TD><TD><strong>Retención</strong></TD><TD><strong>(80.00)</strong></TD></TR>"
        itemsTable += "<TR><TD></TD><TD></TD><TD></TD><TD><strong>Total</strong></TD><TD><strong>2000.00</strong></TD></TR>"
        itemsTable += "</TABLE>"
        contents = contents.Replace("[ITEMS]", itemsTable)

        Dim parsedHtmlElements = HTMLWorker.ParseToList(New StringReader(contents), Nothing)

        For Each htmlElement In parsedHtmlElements
            document.Add(htmlElement)
        Next

        'Dim logo = iTextSharp.text.Image.GetInstance(Server.MapPath(("~/Images/logo.jpg")))
        logo.SetAbsolutePosition(380, 690)
        document.Add(logo)

        document.Close()
        'Para abrir el pdf en una ventana nueva
        'Response.ContentType = "application/pdf"
        'Response.AddHeader("Content-Disposition", String.Format("attachment;filename=Receipt-{0}.pdf", "Orden"))
        'Response.BinaryWrite(output.ToArray())
    End Sub

    Public Sub crearPdfAmericano(ByVal contents As String, ByVal logo As iTextSharp.text.Image, ByVal document As iTextSharp.text.Document)

        'Manual http://www.4guysfromrolla.com/articles/030911-1.aspx
        'Codigo de ejemplo http://www.4guysfromrolla.com/code/PdfCreate.pdf


        document.Open()

        'Contenido
        'Dim parrafo = New Paragraph("Hola")
        'document.Add(parrafo)

        contents = contents.Replace("[folioFiscal]", "Orden")
        contents = contents.Replace("[certificado]", "Precio")
        contents = contents.Replace("[lugar]", "fecha")

        Dim itemsTable = "<TABLE><TR><TH>CANTIDAD</TH> <TH>UNIDAD DE MEDIDA</TH> <th>DESCRIPCIÓN</TH> <TH>PRECIO UNITARIO</TH> <TH>IMPORTE</TH> </TR>"
        For i = 0 To 7 Step 1
            itemsTable += "<TR><TD>1</TD><TD>NA</TD><TD>Flete</TD><TD>2000.00</TD><TD>2000.00</TD></TR>"
        Next
        itemsTable += "<TR><TD></TD><TD></TD><TD></TD><TD><strong>Subtotal</strong></TD><TD><strong>2000.00</strong></TD></TR>"
        itemsTable += "<TR><TD></TD><TD></TD><TD></TD><TD><strong>IVA</strong></TD><TD><strong>320.00</strong></TD></TR>"
        itemsTable += "<TR><TD></TD><TD></TD><TD></TD><TD><strong>Retención</strong></TD><TD><strong>(80.00)</strong></TD></TR>"
        itemsTable += "<TR><TD></TD><TD></TD><TD></TD><TD><strong>Total</strong></TD><TD><strong>2000.00</strong></TD></TR>"
        itemsTable += "</TABLE>"
        contents = contents.Replace("[ITEMS]", itemsTable)

        Dim parsedHtmlElements = HTMLWorker.ParseToList(New StringReader(contents), Nothing)

        For Each htmlElement In parsedHtmlElements
            document.Add(htmlElement)
        Next

        'Dim logo = iTextSharp.text.Image.GetInstance(Server.MapPath(("~/Images/logo.jpg")))
        logo.SetAbsolutePosition(380, 690)
        document.Add(logo)

        document.Close()
        'Para abrir el pdf en una ventana nueva
        'Response.ContentType = "application/pdf"
        'Response.AddHeader("Content-Disposition", String.Format("attachment;filename=Receipt-{0}.pdf", "Orden"))
        'Response.BinaryWrite(output.ToArray())
    End Sub

End Class
