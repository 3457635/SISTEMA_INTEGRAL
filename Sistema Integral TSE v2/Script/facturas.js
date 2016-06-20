<script type="text/javascript">
        $(document).ready(function () {
            $("input:text").mouseenter(function () {
                $("input:text").css("border-style", "Solid");
                $("input:text").css("border-color", "black");
                $("input:text").css("border-width", "1px");
            });

            $("#factura").mouseout(function () {
                $("input:text").css("border-style", "none");
            });
            $("input:submit").mouseenter(function () {
                $("input:text").css("border-style", "none");
            });
        });
        
    </script>   