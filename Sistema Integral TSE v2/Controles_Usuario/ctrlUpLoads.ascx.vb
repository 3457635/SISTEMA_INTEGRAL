Imports System.IO
Imports System.Web.UI

Public Class ctrlUpLoads
    Inherits System.Web.UI.UserControl

    Private exito As Boolean = True

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            imgSubidaXml.Width = 0
            imgSubidaXml.Width = 0
            imgSubidaXml.ImageUrl = ""

            imgSubidaPdf.Width = 0
            imgSubidaPdf.Width = 0
            imgSubidaPdf.ImageUrl = ""

            exito = True

        End If
    End Sub
    Protected Sub btnSubir_Click(sender As Object, e As EventArgs) Handles btnSubirXml.Click
        Dim sExt As String = String.Empty
        Dim sName As String = String.Empty

        imgSubidaXml.Width = 0
        imgSubidaXml.Width = 0
        imgSubidaXml.ImageUrl = ""

        If uploadFile.HasFile Then
            sName = uploadFile.FileName
            sExt = Path.GetExtension(sName)

            If sExt = ".xml" Then
                Dim sfileXml As String = Server.MapPath(String.Format("~/Contabilidad/Facturar/temp/{0}", uploadFile.FileName))
                Try
                    If uploadFile.PostedFile.ContentLength <= 4000000 Then

                        If File.Exists(sfileXml) Then
                            File.Delete(sfileXml)
                        End If
                        uploadFile.SaveAs(sfileXml)
                        hdnFileXml.Value = sfileXml
                        imgSubidaXml.Width = 50
                        imgSubidaXml.Width = 50
                        imgSubidaXml.ImageUrl = "/imagenes/xml.png"
                        lblMensaje.Text = String.Format("Archivo {0} cargado correctamente.", sName.Trim())
                    Else
                        exito = False
                        lblMensaje.Text = "El archivo es demasiado grande."
                    End If
                Catch ex As Exception
                    exito = False
                    lblMensaje.Text = "Error inesperado: al cargar archivo XML."
                End Try
            Else
                exito = False
                lblMensaje.Text = "El archivo no es un XML."
            End If
        Else
            exito = False
            lblMensaje.Text = "Seleccione el archivo que desea subir."
        End If


    End Sub

    Protected Sub btnSubir2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSubirPdf.Click
        Dim sExt As String = String.Empty
        Dim sName As String = String.Empty

        imgSubidaPdf.Width = 0
        imgSubidaPdf.Width = 0
        imgSubidaPdf.ImageUrl = ""

        If uploadFile2.HasFile Then
            sName = uploadFile2.FileName
            sExt = Path.GetExtension(sName)

            If sExt = ".pdf" Then
                Dim sfilePdf As String = Server.MapPath(String.Format("~/Contabilidad/Facturar/temp/{0}", uploadFile2.FileName))
                Try
                    If uploadFile2.PostedFile.ContentLength <= 4000000 Then
                        If File.Exists(sfilePdf) Then
                            File.Delete(sfilePdf)
                        End If
                        uploadFile2.SaveAs(sfilePdf)
                        hdnFilePdf.Value = sfilePdf
                        imgSubidaPdf.Width = 50
                        imgSubidaPdf.Width = 50
                        imgSubidaPdf.ImageUrl = "/imagenes/pdf.png"
                        lblMensaje2.Text = String.Format("Archivo {0} cargado correctamente.", sName.Trim())
                    Else
                        exito = False
                        lblMensaje2.Text = "El archivo es demasiado grande."
                    End If
                Catch ex As Exception
                    exito = False
                    lblMensaje.Text = "Error inesperado: al cargar archivo PDF."
                End Try

            Else
                lblMensaje2.Text = String.Format("El archivo {0} no es un PDF.", sName)
                exito = False
            End If
        Else
            lblMensaje2.Text = "Seleccione el archivo que desea subir."
        End If
    End Sub

    Public Function GetXml() As String
        Return hdnFileXml.Value
    End Function
    Public Function GetPdf() As String
        Return hdnFilePdf.Value
    End Function
    Protected Sub btnCerrar_Click(sender As Object, e As EventArgs) Handles btnSubirCerrar.Click
        btnSubir_Click(sender, e)
        btnSubir2_Click(sender, e)

        If Not exito Then
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "error", "$('#ctl00_ContentPlaceHolder1_lblMensajeUL').text('Error al cargados archivos, verifique por favor'); $('#ctl00_ContentPlaceHolder1_btnSubir').trigger('click');", True)
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "error", "$('#ctl00_ContentPlaceHolder1_lblMensajeUL').text('ERROR: al cargar archivos, vuelva a intentar.');", True)
        Else
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "exito", "alter('ÉXITO, Archivos cargados exitosamente'); $('#ctl00_ContentPlaceHolder1_lblMensajeUL').text('Archivos cargados exitosamente'); alert('ÉXITO, Archivos cargados.');", True)
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "script", "$('#ctl00_ContentPlaceHolder1_lblMensajeUL').text('EXITO: Xml y Pdf fueron cargados exitosamente.');", True)
        End If
    End Sub
    Private Function asignaArchivo(ByVal file As HttpPostedFile) As Byte()
        '' Convertida a arreglo de bytes
        Dim buffer(file.InputStream.Length) As Byte

        file.InputStream.Read(buffer, 0, buffer.Length)

        Return buffer

    End Function
    Public Sub LimpiaUpload()
        imgSubidaXml.Width = 0
        imgSubidaXml.Width = 0
        imgSubidaXml.ImageUrl = ""

        imgSubidaPdf.Width = 0
        imgSubidaPdf.Width = 0
        imgSubidaPdf.ImageUrl = ""

        hdnFileXml.Value = ""
        hdnFilePdf.Value = ""

        lblMensaje.Text = ""
        lblMensaje2.Text = ""

        uploadFile.PostedFile.InputStream.Dispose()
        uploadFile2.PostedFile.InputStream.Dispose()
    End Sub
End Class