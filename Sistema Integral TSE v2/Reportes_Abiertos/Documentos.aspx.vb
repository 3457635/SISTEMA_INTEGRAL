Imports System.IO
Imports System.Web.HttpPostedFile
Imports System.Data.SqlClient

Public Class Documentos
    Inherits System.Web.UI.Page
    Dim tablaData As DataTable
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim filePaths() As String = Directory.GetFiles(Server.MapPath("~/Reportes_Abiertos/DocumentosArea/"))
            Dim files As List(Of ListItem) = New List(Of ListItem)
            For Each filePath As String In filePaths
                files.Add(New ListItem(Path.GetFileName(filePath), filePath))
            Next
            GridView2.DataSource = files
            GridView2.DataBind()

            'Dim conn = New ConexionSQL

            'conn.getDataQuery("Select * from documento_area", tablaData)
            'conn.Cerrar()
            'GridView3.DataSource = tablaData
            'GridView3.DataBind()
        End If


    End Sub
    Sub poblarArbol(ByVal node As TreeNode)
        Dim param As Dictionary(Of String, Object) = New Dictionary(Of String, Object)
        Dim con As New ConexionSQL()
        con.Abrir()
        Dim resultSet As New DataTable
        resultSet = con.RunQuery("Select nombre_area from documentacion_areas where nivel = 2", param)
        con.Cerrar()
        If resultSet.Rows.Count > 0 Then
            Dim row As DataRow
            For Each row In resultSet.Rows
                Dim NewNode As TreeNode = New  _
                    TreeNode(row("nombre_area").ToString())
                NewNode.PopulateOnDemand = True
                NewNode.SelectAction = TreeNodeSelectAction.Expand
                node.ChildNodes.Add(NewNode)
            Next
        End If
    End Sub
    Sub poblarNodos(ByVal node As TreeNode)
        Dim param As Dictionary(Of String, Object) = New Dictionary(Of String, Object)
        param.Add("@idarea", 3)
        Dim con As New ConexionSQL()
        con.Abrir()
        Dim resultSet As New DataTable
        resultSet = con.RunQuery("Select nombre_doc from documentacion_areas where pertenece_a_nivel = @idarea", param)

        con.Cerrar()
        If resultSet.Rows.Count > 0 Then
            Dim row As DataRow
            For Each row In resultSet.Rows

                Dim NewNode As TreeNode = New  _
                    TreeNode(row("nombre_doc").ToString())
                NewNode.PopulateOnDemand = False
                NewNode.SelectAction = TreeNodeSelectAction.Expand
                node.ChildNodes.Add(NewNode)
            Next
        End If
    End Sub

    Protected Sub btnSubir_Click(sender As Object, e As EventArgs) Handles btnSubir.Click


        Dim area As String = rbAreas.SelectedValue

        If fileUDocumentos.HasFile Then
            ' Get the size in bytes of the file to upload.
            Dim filesize As Integer = fileUDocumentos.PostedFile.ContentLength
            'System.IO.Path.GetDirectoryName(saveFileDialog1.FileName)
            Dim str As Stream = fileUDocumentos.PostedFile.InputStream
            Dim br As New BinaryReader(str)
            Dim bytes As Byte() = br.ReadBytes(str.Length)



            ' Dim ruta As String = System.IO.Path.GetDirectoryName(fileUDocumentos.PostedFile.FileName) + fileUDocumentos.PostedFile.FileName
            ' Dim ruta2 As String = Path.GetFullPath(fileUDocumentos.PostedFile.FileName)
            ' Dim archivo As Byte() = File.ReadAllBytes(ruta)

            'Dim con = New ConexionSQL()
            'Dim tabla As New DataTable
            'Dim parametros As New Dictionary(Of String, Object)
            'parametros.Add("@nombre", fileUDocumentos.FileName)
            'parametros.Add("@archivo", bytes)
            'con.Abrir()
            'con.ejecutarProcedimientoDT("Proc_guarda_documento", parametros, tabla)
            'con.Cerrar()

            ' Allow only files less than 2,100,000 bytes (approximately 2 MB) to be uploaded.
            If filesize <= 12100000 Then
                Dim extension As String = System.IO.Path.GetExtension(fileUDocumentos.FileName)
                If (extension.ToLower() = ".pdf" Or extension.ToLower() = ".docx") Then
                    Dim fileName As String = Path.GetFileName(fileUDocumentos.PostedFile.FileName)
                    Dim ruta As String = Server.MapPath("~/Reportes_Abiertos/DocumentosArea/") + fileName
                    fileUDocumentos.PostedFile.SaveAs(ruta)
                    'Dim param As New Dictionary(Of String, Object)
                    'Dim con = New ConexionSQL()
                    'con.Abrir()
                    'Dim ds As New DataTable
                    'ds = con.RunQuery("Select id_documento_area, nombre_area from documentacion_areas where nivel = 2 and nombre_area = '" + area + "'", param)
                    'con.Cerrar()
                    'Dim con2 = New ConexionSQL()
                    'con2.Abrir()
                    'con2.RunQuery("Insert into documentacion_areas values (3,null,'" + fileName + " '," + ds.Rows(0)("id_documento_area").ToString() + ",null,null)", param)
                    'con2.Cerrar()
                    lblMensaje.Text = "Documento guardado"
                    Response.Redirect(Request.Url.AbsoluteUri)
                Else
                    lblMensaje.Text = "Esto no es un archivo permitido por favor verificalo"
                End If

            Else
                lblMensaje.Text = "Archivo muy grande"
            End If
        Else
            lblMensaje.Text = "No seleccionaste ningun archivo"
        End If
        


    End Sub
    Protected Sub descargaArchivo(ByVal sender As Object, ByVal e As EventArgs)
        Dim filePath As String = CType(sender, LinkButton).CommandArgument
        Response.ContentType = ContentType
        Response.AppendHeader("Content-Disposition", ("attachment; filename=" + Path.GetFileName(filePath)))
        Response.WriteFile(filePath)
        Response.End()
    End Sub
    Protected Sub descargaDoc(ByVal sender As Object, ByVal e As EventArgs)
        'Dim row As Integer = CType(sender, LinkButton).CommandArgument
        'Dim documento = New ConexionSQL
        '' documento.getDataQuery("select documento from documento_area where id_documento_area = @id", tablaData)

        'Dim arhivob As Byte() = CType(tablaData.Rows(row)("documento"), Byte())
        'Response.Buffer = True
        'Response.Charset = ""
        'Response.Cache.SetCacheability(HttpCacheability.NoCache)
        'Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        'Response.AddHeader("content-disposition", "attachment;filename=" & tablaData.Rows(row)("nombre").ToString())
        'Response.BinaryWrite(arhivob)
        'Response.Flush()
        'Response.End()
        '  lblMensaje.Text = row
    End Sub

    Protected Sub TreeView1_TreeNodePopulate(sender As Object, e As TreeNodeEventArgs) Handles TreeView1.TreeNodePopulate
        'If e.Node.ChildNodes.Count = 0 Then
        '    Select Case e.Node.Depth
        '        Case 0
        '            poblarArbol(e.Node)
        '        Case 1
        '            poblarNodos(e.Node)
        '    End Select
        'End If
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        Dim filePaths() As String = Directory.GetFiles(Server.MapPath("~/Reportes_Abiertos/DocumentosArea/" + DropDownList1.SelectedValue + "/"))
        Dim files As List(Of ListItem) = New List(Of ListItem)
        For Each filePath As String In filePaths
            files.Add(New ListItem(Path.GetFileName(filePath), filePath))
        Next
        GridView2.DataSource = files
        GridView2.DataBind()
    End Sub
End Class