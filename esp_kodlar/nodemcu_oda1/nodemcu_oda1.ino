#include <ESP8266WiFi.h>
#include <ArduinoJson.h>
#include <DHT.h>

const int DHTPIN = D7;
#define DHTTYPE DHT11

const char* const ssid = "";
const char* const password = "";

const char* const g_host = "script.google.com";
const char* const GScriptId = "";
const int httpsPort = 443;
const int RELAY = D1;
String host = "gsx2json.com";

int temp_counter = 1;

DHT dht(DHTPIN, DHTTYPE);

void setup() 
{

  pinMode(RELAY, OUTPUT);
  Serial.begin(115200);
  delay(10);

  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  dht.begin();
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");  
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}


void loop() 
{
  Serial.print("connecting to ");
  Serial.println(host);

  WiFiClientSecure client;
  const int httpPort = 443;
  
  client.setInsecure();
  
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
  }

  String url = "/api?id=148r8M7CVsmZuGy7VsPWBGoeT3hlCprBk8xCd0vTF_rs&sheet=oda_1_isik&api_key=";
  String payload = "";
  
  Serial.print("Requesting URL: ");
  Serial.println(url);

  // This will send the request to the server
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "User-Agent: NodeMCU\r\n" +
               "Connection: close\r\n\r\n");

  while(client.connected())
  {
    payload = client.readStringUntil('\n');
    if (payload == "\r") {break;}
  }

  payload = client.readStringUntil('}');
  payload += "}}";

  Serial.println(payload);

  client.stop();
  Serial.println("closing connection");

  DynamicJsonBuffer jsonBuffer(192);
  JsonObject& root = jsonBuffer.parseObject(payload);
  
  if (!root.success()) {
    Serial.println(F("Parsing failed!"));
    return;
  }

  JsonArray& rowsArray = root["columns"]["isik1_durum"];
  int rows_array_size = rowsArray.size();
  Serial.println(F("Response:"));
  String isik_durum = root["columns"]["isik1_durum"][rows_array_size-1].as<String>();
  Serial.println("Isik Durum: " + isik_durum);
  if(!(isik_durum.toInt()))
  {
    Serial.println("Isik Acildi");
    digitalWrite(RELAY, HIGH);
  }
  else
  {
    Serial.println("Isik Kapandi");
    digitalWrite(RELAY, LOW);
  }

  client.stop();

  Serial.println();
  Serial.println("closing connection");

  if(temp_counter % 121 == 0) //121
  {
    postHumidityTemp();
    temp_counter = 1;
  }
  
  temp_counter+=1;
}

int postHumidityTemp()
{ 
  
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  Serial.println("veriler");
  Serial.println(h);
  Serial.println(t);

  if (isnan(h) || isnan(t)) 
  {
    Serial.println("DHT sensorunun olcumunde hata oldu!");
    return 0;
  }

  WiFiClientSecure client;
  const int httpPort = 443;
  
  client.setInsecure();
  
  if (!client.connect(g_host, httpPort)) {
    Serial.println("connection failed");
    return 0;
  }

  String url = "/macros/s/AKfycbzetm_JaZh6_-MEuyL0mlgjX7md-wnVy6en95OvTk3dOyYLhmXVAeaSqVVO0H7_b4k1/exec?";
  
  url += "sicaklik1=" + String(t);
  url += "&";
  url += "nem1=" + String(h);
  
  Serial.print("Requesting URL: ");
  Serial.println(url);

  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + g_host + "\r\n" + 
               "Connection: close\r\n\r\n");

  client.stop();
  
  return 1;
}
