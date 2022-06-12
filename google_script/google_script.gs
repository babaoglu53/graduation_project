var sheet_id = '';

function doGet(e) {
  Logger.log( JSON.stringify(e) );

  var result = 'Ok';

  if (e.parameter == 'undefined') 
  {
    result = 'Hatalı Parametre!!';
  }
  else 
  {
    var rowData = [];

    rowData[0] = Utilities.formatDate(new Date(), "GMT+3", "dd/MM/yyyy HH:mm:ss");

    for (var param in e.parameter)
    {
      Logger.log('In for loop, param='+ param);
      var value = stripQuotes(e.parameter[param]);
      Logger.log(param +':'+ e.parameter[param]);
      
      switch(param)
      {
        case 'isik1_durum':
          var sheet = selectSheet("oda_1_isik");
          var newRow = sheet.getLastRow()+1;
          rowData[1]= value;
          result = 'isik1_durum değeri B kolonuna yazıldı';
          break;

        case 'isik2_durum':
          var sheet = selectSheet("oda_2_isik");
          var newRow = sheet.getLastRow()+1;
          rowData[1]= value;
          result = 'isik2_durum değeri B kolonuna yazıldı';
          break;

        case 'isik3_durum':
          var sheet = selectSheet("oda_3_isik");
          var newRow = sheet.getLastRow()+1;
          rowData[1]= value;
          result = 'isik3_durum değeri B kolonuna yazıldı';
          break;

        case 'salon_isik':
          var sheet = selectSheet("salon_isik");
          var newRow = sheet.getLastRow()+1;
          rowData[1]= value;
          result = 'salon_isik değeri B kolonuna yazıldı';
          break;

        case 'sicaklik1':
          var sheet = selectSheet("oda_1_sicaklik");
          var newRow = sheet.getLastRow()+1;
          rowData[1]= value;
          result = 'sicaklik1 değeri B kolonuna yazıldı';
          break;

        case 'sicaklik2':
          var sheet = selectSheet("oda_2_sicaklik");
          var newRow = sheet.getLastRow()+1;
          rowData[1]= value;
          result = 'sicaklik2 değeri B kolonuna yazıldı';
          break;

        case 'sicaklik3':
          var sheet = selectSheet("oda_3_sicaklik");
          var newRow = sheet.getLastRow()+1;
          rowData[1]= value;
          result = 'sicaklik3 değeri B kolonuna yazıldı';
          break;

        case 'sicaklik4':
          var sheet = selectSheet("salon_sicaklik");
          var newRow = sheet.getLastRow()+1;
          rowData[1]= value;
          result = 'sicaklik_salon değeri B kolonuna yazıldı';
          break;

        case 'nem1':
          var sheet = selectSheet("oda_1_sicaklik");
          var newRow = sheet.getLastRow()+1;
          rowData[2]= value;
          result = 'nem1 değeri C kolonuna yazıldı';
          break;

        case 'nem2':
          var sheet = selectSheet("oda_2_sicaklik");
          var newRow = sheet.getLastRow()+1;
          rowData[2]= value;
          result = 'nem2 değeri C kolonuna yazıldı';
          break;

        case 'nem3':
          var sheet = selectSheet("oda_3_sicaklik");
          var newRow = sheet.getLastRow()+1;
          rowData[2]= value;
          result = 'nem3 değeri C kolonuna yazıldı';
          break;

        case 'nem_salon':
          var sheet = selectSheet("salon_sicaklik");
          var newRow = sheet.getLastRow()+1;
          rowData[2]= value;
          result = 'nem_salon değeri C kolonuna yazıldı';
          break;

        case 'kapi_durum':
          var sheet = selectSheet("giris");
          var newRow = sheet.getLastRow()+1;
          rowData[1]= value;
          result = 'kapi_durum değeri B kolonuna yazıldı';
          break;
        
        default:
          result = 'Parametre hatalı!';
      }
    }
  
    Logger.log(JSON.stringify(rowData));

    var newRange = sheet.getRange(newRow, 1, 1, rowData.length);
    newRange.setValues([rowData]);
  }

  return ContentService.createTextOutput(result);
}


function selectSheet(sheet_name){
  return SpreadsheetApp.openById(sheet_id).getSheetByName(sheet_name);
}

function stripQuotes( value )
{
  return value.replace(/^['']|['']$/g, '');
}





