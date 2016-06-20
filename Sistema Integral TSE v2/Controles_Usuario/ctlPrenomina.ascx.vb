Public Class ctlPrenomina
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizarG.Click
        If Not String.IsNullOrEmpty(txbFecha1.Text) And Not String.IsNullOrEmpty(txbFecha2.Text) Then
            Dim inicio = txbFecha1.Text
            Dim fin = txbFecha2.Text

            Dim tabla As New HtmlTable
            tabla.Border = 1
            tabla.CellSpacing = 0

            Dim total As Integer = 0


            Dim choferes = (From consulta In db.empleados
                           Where (consulta.id_puesto = 1 Or consulta.id_puesto = 3) And
                           consulta.persona.id_status = 5
                           Select consulta.id_empleado, consulta.persona.primer_nombre, consulta.persona.apellido_paterno).OrderBy(Function(x) x.primer_nombre)


            For Each chofer In choferes
                Dim id_chofis = chofer.id_empleado
                Dim nombre_chofer = chofer.primer_nombre.ToString() + " " + chofer.apellido_paterno.ToString()

                Dim tarifa_total = obtener_nomina_chofer(inicio, fin, id_chofis)
                total += tarifa_total

                If tarifa_total > 0 Then
                    Dim fila As New HtmlTableRow
                    Dim celda1 As New HtmlTableCell
                    Dim celda2 As New HtmlTableCell
                    celda1.InnerHtml = CStr(nombre_chofer)
                    fila.Cells.Add(celda1)

                    celda2.InnerHtml = String.Format("{0:c0}", tarifa_total)
                    fila.Cells.Add(celda2)
                    tabla.Rows.Add(fila)

                End If

                
            Next
            lblTotal.Text = String.Format("{0:c0}", total)

            phrTabla.Controls.Add(tabla)

        End If
    End Sub
End Class