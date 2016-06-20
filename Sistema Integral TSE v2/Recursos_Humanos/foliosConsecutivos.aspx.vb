Imports System.IO

Imports System.Data
Imports System.Drawing
Imports System.Data.SqlClient
Imports System.Configuration

Public Class foliosConsecutivos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered
    End Sub
    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        ExportToExcel()
    End Sub
    Protected Sub ExportToExcel()
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment;filename=Folios " + txbFechaInicio.Text + "-" + txbFechaFin.Text + ".xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"
        Using sw As New StringWriter()
            Dim hw As New HtmlTextWriter(sw)

            'To Export all pages
            'GridView2.AllowPaging = False
            ' Me.BindGrid()

            GridView2.HeaderRow.BackColor = Color.White
            For Each cell As TableCell In GridView2.HeaderRow.Cells
                cell.BackColor = GridView2.HeaderStyle.BackColor
            Next
            For Each row As GridViewRow In GridView2.Rows
                row.BackColor = Color.White
                For Each cell As TableCell In row.Cells
                    If row.RowIndex Mod 2 = 0 Then
                        cell.BackColor = GridView2.AlternatingRowStyle.BackColor
                    Else
                        cell.BackColor = GridView2.RowStyle.BackColor
                    End If
                    cell.CssClass = "textmode"
                Next
            Next

            GridView2.RenderControl(hw)
            'style to format numbers to string
            Dim style As String = "<style> .textmode { } </style>"
            Response.Write(style)
            Response.Output.Write(sw.ToString())
            Response.Flush()
            Response.[End]()
        End Using
    End Sub
End Class