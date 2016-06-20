Public Class flujo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year.ToString()
        End If
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Dim db As New DataClasses1DataContext()
        Dim t As New HtmlTable
        t.Border = 1
        t.CellSpacing = 0
        Dim hoy = Now().AddHours(-7)
        If IsNumeric(txbAno.Text) Then
            For i As Integer = 1 To 5
                Dim fecha_inicio As Date = fecha_arranque(ddlTrimestre.SelectedValue)
                Dim semana_fin As Integer
                Dim semana_inicio = DatePart(DateInterval.WeekOfYear, fecha_inicio) - 1

                If ddlTrimestre.SelectedValue <> 4 Then
                    semana_fin = DatePart(DateInterval.WeekOfYear, fecha_inicio.AddMonths(3))
                Else
                    semana_fin = 53
                End If
                Dim fila As New HtmlTableRow
                Dim color_encabezado = "white"
                Dim fondo = "white"
                For j As Integer = semana_inicio To semana_fin
                    Dim celda As New HtmlTableCell
                    If i = 1 Then 'Header'
                        If j = semana_inicio Then
                            celda.InnerHtml = ""
                        Else
                            Dim fecha_fin = fecha_inicio.AddDays(6)
                            If hoy >= fecha_inicio And hoy <= fecha_fin Then
                                color_encabezado = "red"
                                fondo = "FFFF66"
                            Else
                                color_encabezado = "black"
                                fondo = "white"
                            End If
                            celda.InnerHtml = "<FONT size='1' bgcolor='" + fondo + "' color='" + color_encabezado + "'><b><U>Semana " + CStr(j) + "</U></b><br><I>" + fecha_inicio + "</I><br>" + fecha_fin + "</FONT>"
                            celda.BgColor = fondo
                            fecha_inicio = fecha_fin.AddDays(1).ToString
                        End If
                    End If
                    If i = 2 Then
                        If j = semana_inicio Then
                            celda.InnerHtml = "Cuentas por cobrar"
                        Else
                            Dim fecha_fin As Date = fecha_inicio.AddDays(6)
                            If hoy >= fecha_inicio And hoy <= fecha_fin Then
                                color_encabezado = "red"
                                fondo = "FFFF66"
                            Else
                                color_encabezado = "black"
                                fondo = "white"
                            End If

                            Dim cuentasxcobrarMN = (From consulta In db.fechas_facturacions
                             Where (consulta.factura.total IsNot Nothing And
                             consulta.fecha.fecha >= fecha_inicio And
                             consulta.fecha.fecha <= fecha_fin And
                             consulta.fecha.tipo_fecha = 6 And
                             consulta.factura.Cancelada = False And
                             consulta.factura.facturada_dolares = False And
                             Not (From consulta2 In db.fechas_facturacions
                             Where (consulta2.fecha.tipo_fecha = 7)
                              Select consulta2.id_factura).Contains(consulta.id_factura))
                             Select consulta.factura.importe).Sum()




                            Dim cuentasxcobrarDlls = (From consulta In db.fechas_facturacions
                             Where (consulta.factura.importe IsNot Nothing And
                             consulta.fecha.fecha >= fecha_inicio And
                             consulta.fecha.fecha <= fecha_fin And
                             consulta.fecha.tipo_fecha = 6 And
                             consulta.factura.Cancelada = False And
                             consulta.factura.facturada_dolares = True And
                             Not (From consulta2 In db.fechas_facturacions
                             Where (consulta2.fecha.tipo_fecha = 7)
                              Select consulta2.id_factura).Contains(consulta.id_factura))
                             Select consulta.factura.importe).Sum()
                            Dim mn = String.Format("{0:c}", cuentasxcobrarMN)

                            If Not String.IsNullOrEmpty(mn) Then
                                celda.InnerHtml = "<a href='CxC.aspx?fecha_inicio=" + fecha_inicio + "&fecha_fin=" + fecha_fin + "&tipo_query=1' target='blank'><FONT size='2'> " + mn + "<br><br> " + String.Format("{0:c}", cuentasxcobrarDlls) + " dlls.</font></a>"
                            Else
                                celda.InnerHtml = ""
                            End If
                            celda.BgColor = fondo
                            fecha_inicio = fecha_fin.AddDays(1)
                        End If
                    End If
                    If i = 3 Then
                        If j = semana_inicio Then
                            celda.InnerHtml = "Cuentas cobradas"
                        Else
                            Dim fecha_fin As Date = fecha_inicio.AddDays(6)
                            If hoy >= fecha_inicio And hoy <= fecha_fin Then
                                color_encabezado = "red"
                                fondo = "FFFF66"
                            Else
                                color_encabezado = "black"
                                fondo = "white"
                            End If

                            Dim cuentasxcobradasMN = (From consulta In db.fechas_facturacions
                             Where consulta.factura.total IsNot Nothing And
                             consulta.fecha.fecha >= fecha_inicio And
                             consulta.fecha.fecha <= fecha_fin And
                            consulta.fecha.tipo_fecha = 7 And
                            consulta.factura.Cancelada = False And
                            consulta.factura.facturada_dolares = False
                             Select consulta.factura.importe).Sum()

                            Dim cuentasxcobradasDlls = (From consulta In db.fechas_facturacions
                             Where consulta.factura.importe IsNot Nothing And
                             consulta.fecha.fecha >= fecha_inicio And
                             consulta.fecha.fecha <= fecha_fin And
                             consulta.fecha.tipo_fecha = 7 And
                             consulta.factura.Cancelada = False And
                             consulta.factura.facturada_dolares = True
                             Select consulta.factura.importe).Sum()

                            celda.InnerHtml = "<a href='CxC.aspx?fecha_inicio=" + fecha_inicio + "&fecha_fin=" + fecha_fin + "&tipo_query=2' target='blank'> <FONT size='2'><br> <br>" + String.Format("{0:c}", cuentasxcobradasMN) + "<br><br> " + String.Format("{0:c}", cuentasxcobradasDlls) + " dlls.</font></a>"


                            celda.BgColor = fondo

                            fecha_inicio = fecha_fin.AddDays(1)
                        End If
                    End If
                    If i = 4 Then
                        If j = semana_inicio Then
                            celda.InnerHtml = "Cuentas por pagar"
                        Else
                            Dim fecha_fin As Date = fecha_inicio.AddDays(6)
                            If hoy >= fecha_inicio And hoy <= fecha_fin Then
                                color_encabezado = "red"
                                fondo = "FFFF66"
                            Else
                                color_encabezado = "black"
                                fondo = "white"
                            End If

                            Dim cuentasxpagar = (From consulta In db.proveedores_pagos
                                                Where consulta.fecha_programacion_pago >= fecha_inicio And
                                                consulta.gasto.id_status = 5 And consulta.fecha_pago Is Nothing And
                                                consulta.fecha_programacion_pago <= fecha_fin
                                                Select consulta.gasto.cantidad).Sum()

                            celda.InnerHtml = "<a href='cxPagar/cxp.aspx?fecha_inicio=" + fecha_inicio + "&fecha_fin=" + fecha_fin + "&tipo_query=1' target='blank' <FONT size='2'><br>" + String.Format("{0:c}", cuentasxpagar) + "</font></a>"
                            fecha_inicio = fecha_fin.AddDays(1)
                            celda.BgColor = fondo
                        End If
                    End If
                    If i = 5 Then
                        If j = semana_inicio Then
                            celda.InnerHtml = "Cuentas pagadas"
                        Else
                            Dim fecha_fin As Date = fecha_inicio.AddDays(6)
                            If hoy >= fecha_inicio And hoy <= fecha_fin Then
                                color_encabezado = "red"
                                fondo = "FFFF66"
                            Else
                                color_encabezado = "black"
                                fondo = "white"
                            End If

                            Dim cuentasxpagar = (From consulta In db.proveedores_pagos
                                                Where consulta.fecha_pago >= fecha_inicio And
                                                consulta.gasto.id_status = 5 And
                                                consulta.fecha_pago <= fecha_fin
                                                Select consulta.gasto.cantidad).Sum()

                            celda.InnerHtml = "<a href='cxPagar/cxp.aspx?fecha_inicio=" + fecha_inicio + "&fecha_fin=" + fecha_fin + "&tipo_query=1' target='blank' <FONT size='2'><br>" + String.Format("{0:c}", cuentasxpagar) + "</font></a>"
                            fecha_inicio = fecha_fin.AddDays(1)
                            celda.BgColor = fondo
                        End If
                    End If
                    fila.Cells.Add(celda)

                Next
                t.Rows.Add(fila)

            Next
            plhFlujo.Controls.Add(t)
        Else
            lblMensaje.Text = "Hay un error en el campo del Año."
        End If
    End Sub

   
    Protected Function fecha_arranque(ByVal trimestre)


        Dim fecha As DateTime = Convert.ToDateTime("01/01/" + txbAno.Text)
        Dim fechaInicio As DateTime

        If ddlTrimestre.SelectedValue = 1 Then
            fechaInicio = fecha
        End If

        If ddlTrimestre.SelectedValue = 2 Then
            fechaInicio = fecha.AddMonths(3)
        End If

        If ddlTrimestre.SelectedValue = 3 Then
            fechaInicio = fecha.AddMonths(6)
        End If

        If ddlTrimestre.SelectedValue = 4 Then
            fechaInicio = fecha.AddMonths(9)
        End If

        Return fechaInicio

    End Function
   
End Class