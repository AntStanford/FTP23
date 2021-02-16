function computeMonthlyPayment(prin, numPmts, intRate) {
    var pmtAmt = 0;
    if (intRate == 0) {
        pmtAmt = prin / numPmts;
    } else {
        intRate = intRate / 100.0 / 12;
        var pow = 1;
        for (var j = 0; j < numPmts; j++)
            pow = pow * (1 + intRate);
        pmtAmt = (prin * pow * intRate) / (pow - 1);
    }
    return pmtAmt;
}
function fn(num, places, comma) {
    var isNeg = 0;
    if (num < 0) {
        num = num * -1;
        isNeg = 1;
    }
    var myDecFact = 1;
    var myPlaces = 0;
    var myZeros = "";
    while (myPlaces < places) {
        myDecFact = myDecFact * 10;
        myPlaces = Number(myPlaces) + Number(1);
        myZeros = myZeros + "0";
    }
    onum = Math.round(num * myDecFact) / myDecFact;
    integer = Math.floor(onum);

    if (Math.ceil(onum) == integer) {
        decimal = myZeros;
    } else {
        decimal = Math.round((onum - integer) * myDecFact)
    }
    decimal = decimal.toString();
    if (decimal.length < places) {
        fillZeroes = places - decimal.length;
        for (z = 0; z < fillZeroes; z++) {
            decimal = "0" + decimal;
        }
    }

    if (places > 0) {
        decimal = "." + decimal;
    }

    if (comma == 1) {
        integer = integer.toString();
        var tmpnum = "";
        var tmpinteger = "";
        var y = 0;

        for (x = integer.length; x > 0; x--) {
            tmpnum = tmpnum + integer.charAt(x - 1);
            y = y + 1;
            if (y == 3 & x > 1) {
                tmpnum = tmpnum + ",";
                y = 0;
            }
        }

        for (x = tmpnum.length; x > 0; x--) {
            tmpinteger = tmpinteger + tmpnum.charAt(x - 1);
        }


        finNum = tmpinteger + "" + decimal;
    } else {
        finNum = integer + "" + decimal;
    }

    if (isNeg == 1) {
        finNum = "-" + finNum;
    }

    return finNum;
}




function sn(num) {

    num = num.toString();


    var len = num.length;
    var rnum = "";
    var test = "";
    var j = 0;

    var b = num.substring(0, 1);
    if (b == "-") {
        rnum = "-";
    }

    for (i = 0; i <= len; i++) {

        b = num.substring(i, i + 1);

        if (b == "0" || b == "1" || b == "2" || b == "3" || b == "4" || b == "5" || b == "6" || b == "7" || b == "8" || b == "9" || b == ".") {
            rnum = rnum + "" + b;

        }

    }

    if (rnum == "" || rnum == "-") {
        rnum = 0;
    }

    rnum = Number(rnum);

    return rnum;

}

function computeForm(form) {

    var Vclosingcosts = document.calc.closingcosts.value;
    if (Vclosingcosts == 0 || Vclosingcosts == "") {
        Vclosingcosts = 0;
    }
    var Vprincipal = sn(parseFloat(document.calc.principal.value) + parseFloat(Vclosingcosts));
    var VintRate = sn(document.calc.intRate.value);
    var VnumYears = sn(document.calc.numYears.value);
    var VannualTax = document.calc.annualTax.value;
    var VmonthlyTax = 0;
    if (VannualTax == 0 || VannualTax == "") {
        VannualTax = 0;
        VmonthlyTax = 0;
    } else {
        VannualTax = sn((VannualTax * document.calc.homevalue.value) / 100);
        VmonthlyTax = VannualTax / 12;
        VmonthlyTax *= 100;
        VmonthlyTax = Math.round(VmonthlyTax);
        VmonthlyTax /= 100;
    }

    var VannualInsurance = document.calc.annualInsurance.value;
    var VmonthlyInsurance = 0;
    if (VannualInsurance == 0 || VannualInsurance == "") {
        VannualInsurance = 0;
        VmonthlyInsurance = 0;
    } else {
        VannualInsurance = sn((VannualInsurance * document.calc.homevalue.value) / 100);
        VmonthlyInsurance = VannualInsurance / 12;
        VmonthlyInsurance *= 100;
        VmonthlyInsurance = Math.round(VmonthlyInsurance);
        VmonthlyInsurance /= 100;
    }

    var Vhomevalue = document.calc.homevalue.value;
    var VmonthlyPMI = document.calc.monthlyPMI.value;

    if (VmonthlyPMI == 0 || VmonthlyPMI == "" || Vhomevalue > 1.249999999 * Vprincipal) {
        VmonthlyPMI = 0;
    } else {
        VmonthlyPMI = sn((VmonthlyPMI * document.calc.principal.value) / 100);
        VmonthlyPMI = VmonthlyPMI / 12;
        VmonthlyPMI *= 100;
        VmonthlyPMI = Math.round(VmonthlyPMI);
        VmonthlyPMI /= 100;
    }

    var VotherPmts = Number(VmonthlyTax) + Number(VmonthlyInsurance) + Number(VmonthlyPMI);

    var VnumPmts = VnumYears * 12;

    var VpmtAmt = computeMonthlyPayment(Vprincipal, VnumPmts, VintRate);
    var VtotalMtgPmt = Number(VpmtAmt) + Number(VotherPmts);
    var Vdownpayment = sn(parseFloat(document.calc.homevalue.value) - parseFloat(document.calc.principal.value));

    document.calc.monthlyPI.value = "$" + fn(VpmtAmt, 2, 1);
    document.calc.otherPmts.value = "$" + fn(VotherPmts, 2, 1);
    document.calc.monthlyPmt.value = "$" + fn(VtotalMtgPmt, 2, 1);
    document.calc.downpayment.value = "$" + fn(Vdownpayment, 2, 1);

}


function monthlyAmortSched(form) {

    {


        var Vprincipal = sn(parseFloat(document.calc.principal.value) + parseFloat(document.calc.closingcosts.value));
        var VintRate = sn(document.calc.intRate.value);
        var VnumYears = sn(document.calc.numYears.value);
        var VannualTax = document.calc.annualTax.value;
        var VmonthlyTax = 0;
        if (VannualTax == 0 || VannualTax == "") {
            VannualTax = 0;
            VmonthlyTax = 0;
        } else {
            VannualTax = sn(VannualTax);
            VmonthlyTax = VannualTax / 12;
            VmonthlyTax *= 100;
            VmonthlyTax = Math.round(VmonthlyTax);
            VmonthlyTax /= 100;
        }

        var VannualInsurance = document.calc.annualInsurance.value;
        var VmonthlyInsurance = 0;
        if (VannualInsurance == 0 || VannualInsurance == "") {
            VannualInsurance = 0;
            VmonthlyInsurance = 0;
        } else {
            VannualInsurance = sn(VannualInsurance);
            VmonthlyInsurance = VannualInsurance / 12;
            VmonthlyInsurance *= 100;
            VmonthlyInsurance = Math.round(VmonthlyInsurance);
            VmonthlyInsurance /= 100;
        }

        var VmonthlyPMI = document.calc.monthlyPMI.value;
        if (VmonthlyPMI == 0 || VmonthlyPMI == "") {
            VmonthlyPMI = 0;
        } else {
            VmonthlyPMI = sn(VmonthlyPMI);
        }

        var VotherPmts = Number(VmonthlyTax) + Number(VmonthlyInsurance) + Number(VmonthlyPMI);

        var VnumPmts = VnumYears * 12;

        var pmtAmt = computeMonthlyPayment(Vprincipal, VnumPmts, VintRate);
        var VtotalMtgPmt = Number(pmtAmt) + Number(VotherPmts);

        var prin = Vprincipal;

        var Vint = VintRate;

        if (Vint >= 1) {
            Vint /= 100;
        }
        Vint /= 12;

        var nPer = VnumPmts;

        var intPort = 0;
        var accumInt = 0;
        var prinPort = 0;
        var accumPrin = 0;
        var count = 0;
        var pmtRow = "";
        var pmtNum = 0;

        var today = new Date();
        var dayFactor = today.getTime();
        var pmtDay = today.getDate();
        var loanMM = today.getMonth() + 1;
        var loanYY = today.getYear();
        if (loanYY < 1900) {
            loanYY += 1900;
        }
        var loanDate = (loanMM + "/" + pmtDay + "/" + loanYY);
        var monthMS = 86400000 * 30.4;
        var pmtDate = 0;
        var displayPmtAmt = 0;
        var accumYearPrin = 0;
        var accumYearInt = 0;

        while (count < nPer) {

            if (count < (nPer - 1)) {

                intPort = prin * Vint;
                intPort *= 100;
                intPort = Math.round(intPort);
                intPort /= 100;

                accumInt = Number(accumInt) + Number(intPort);
                accumYearInt = Number(accumYearInt) + Number(intPort);

                prinPort = Number(pmtAmt) - Number(intPort);
                prinPort *= 100;
                prinPort = Math.round(prinPort);
                prinPort /= 100;

                accumPrin = Number(accumPrin) + Number(prinPort);
                accumYearPrin = Number(accumYearPrin) + Number(prinPort);

                prin = Number(prin) - Number(prinPort);

                displayPmtAmt = Number(prinPort) + Number(intPort);

            } else {

                intPort = prin * Vint;
                intPort *= 100;
                intPort = Math.round(intPort);
                intPort /= 100;

                accumInt = Number(accumInt) + Number(intPort);
                accumYearInt = Number(accumYearInt) + Number(intPort);

                prinPort = prin;

                accumPrin = Number(accumPrin) + Number(prinPort);
                accumYearPrin = Number(accumYearPrin) + Number(prinPort);

                prin = 0;

                //pmtAmt = Number(intPort) + Number(prinPort);
                displayPmtAmt = Number(prinPort) + Number(intPort);
            }

            count = Number(count) + Number(1);

            pmtNum = Number(pmtNum) + Number(1);

            dayFactor = Number(dayFactor) + Number(monthMS);

            pmtDate = new Date(dayFactor);

            pmtMonth = pmtDate.getMonth();

            pmtMonth = pmtMonth + 1;

            pmtYear = pmtDate.getYear();
            if (pmtYear < 1900) {
                pmtYear += 1900;
            }


            pmtString = (pmtMonth + "/" + pmtDay + "/" + pmtYear);

            pmtRow += "<tr><td align=right><font face='arial'><small>" + pmtNum + "</small></td>";
            pmtRow += "<td align=right><font face='arial'><small>" + pmtString + "</small></td>";
            pmtRow += "<td align=right><font face='arial'><small>" + "$" + fn(prinPort, 2, 1) + "</small></td>";
            pmtRow += "<td align=right><font face='arial'><small>" + "$" + fn(intPort, 2, 1) + "</small></td>";
            pmtRow += "<td align=right><font face='arial'><small>" + "$" + fn(displayPmtAmt, 2, 1) + "</small></td>";
            pmtRow += "<td align=right><font face='arial'><small>" + "$" + fn(prin, 2, 1) + "</small></td></tr>";


            if (pmtMonth == 12 || count == nPer) {

                pmtRow += "<tr bgcolor='#dddddd'><td align=right><font face='arial'><small>Total</small></td>";
                pmtRow += "<td align=left><font face='arial'><small>" + pmtYear + "</small></td>";
                pmtRow += "<td align=right><font face='arial'><small>" + "$" + fn(accumYearPrin, 2, 1) + "</small></td>";
                pmtRow += "<td align=right><font face='arial'><small>" + "$" + fn(accumYearInt, 2, 1) + "</small></td>";
                pmtRow += "<td align=right><font face='arial'><small> </small></td>";
                pmtRow += "<td align=right><font face='arial'><small> </small></td></tr>";


                accumYearPrin = 0;
                accumYearInt = 0;

            }

            if (count > 600) {
                alert("Using your current entries you will never pay off this loan.");
                break;
            } else {
                continue;
            }

        }



        var part1 = "<head><title>Amortization Schedule</title></head>";
        part1 += "<body bgcolor= '#FFFFFF'><br /><br /><center><font face='arial'>";
        part1 += "<big><strong>Amortization Schedule</strong></big></center>";


        var part2 = "<center><table border=1 cellpadding=2 cellspacing=0>";
        part2 += "<tr><td colspan=6><font face='arial'><small><strong>Loan ";
        part2 += "Date: " + loanDate + "<br />Principal: $" + fn(Vprincipal, 2, 1) + "<br /># of ";
        part2 += "Payments: " + nPer + "<br />Interest Rate: " + fn(VintRate, 3, 0) + "%<br />";
        part2 += "Payment: $" + fn(pmtAmt, 2, 1) + "</strong></small></td></tr><tr><td colspan=6>";
        part2 += "<center><font face='arial'><strong>Schedule of Payments</strong><br /><font face='arial'>";
        part2 += "<small><small>Please allow for slight rounding differences.</small></small></center></td></tr>";
        part2 += "<tr bgcolor='silver'><td align='center'><font face='arial'><small><strong>Pmt #</strong></small></td>";
        part2 += "<td align='center'><font face='arial'><small><strong>Date</strong></small></td>";
        part2 += "<td align='center'><font face='arial'><small><strong>Principal</strong></small></td>";
        part2 += "<td align='center'><font face='arial'><small><strong>Interest</strong></small></td>";
        part2 += "<td align='center'><font face='arial'><small><strong>Payment</strong></small></td>";
        part2 += "<td align='center'><font face='arial'><small><strong>Balance</strong></small></td></tr>";

        var part3 = ("" + pmtRow + "");

        var part4 = "<tr><td colspan='2'><font face='arial'><small><strong>Grand Total</strong></small></td>";
        part4 += "<td align=right><font face='arial'><small><strong>" + "$" + fn(accumPrin, 2, 1) + "</strong></small></td>";
        part4 += "<td align=right><font face='arial'><small><strong>" + "$" + fn(accumInt, 2, 1) + "</strong></small></td>";
        part4 += "<td> </td><td> </td></tr></table><br /><center><form method='post'>";
        part4 += "<input type='button' value='Close Window' onClick='window.close()'></form>";
        part4 += "</center></body></html>";


        var schedule = (part1 + "" + part2 + "" + part3 + part4 + "");
        reportWin = window.open("", "", "width=500,height=400,toolbar=yes,menubar=yes,scrollbars=yes");
        reportWin.document.write(schedule);
        reportWin.document.close();

    }

}


function clear_results(form) {

    document.calc.monthlyPI.value = "";
    document.calc.otherPmts.value = "";
    document.calc.monthlyPmt.value = "";

}