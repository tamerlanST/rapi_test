#!/bin/bash
source ../lib.sh

################################
# Get hw types
################################

# Params list
params='{"filterType":"name","filterValue":["ATrack"],"includeType":1}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=core/get_hw_types&sid=$sid"`
hwid=`echo $response | jq '.[].id'`

equivalent='[{"id":'$hwid',"uid2":1,"name":"ATrack","hw_category":"auto","tp":"20219","up":"20219"}]'

if [[ "$equivalent" != "$response" ]];
    then error
fi


################################
# Create unit
################################

# Params list
params='{"creatorId":'$uitemId',"name":"update_report","hwTypeId":'$hwid',"dataFlags":1}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=core/create_unit&sid=$sid"`
newObjectID=`echo $response | jq '.item.id'`
equivalent='{"item":{"nm":"update_report","cls":2,"id":'$newObjectID',"mu":0,"uacl":880333094911},"flags":1}'

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Object create error";
elif [[ "$equivalent" != "$response" ]];
    then error $response
fi

################################
# Import messages
################################

# Params list
params='{"itemId":'$newObjectID',"eventHash":"message_layer1"}'

# Execute command and compare with equivalent
response=`curl -sX POST -F "params=$params" -F "filename=@data/test.wlb" "$server?svc=exchange/import_messages&sid=$sid"`
equivalent='{}'

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Import messages error";
elif [[ "$equivalent" != "$response" ]];
    then error
fi

sleep 1


method='report/update_report'

################################
# Create report
################################

# Params list
params='{"n":"New report","ct":"avl_unit","p":"{\"bind\":null}","tbl":[{"n":"unit_stats","l":"Статистика","f":0,"c":"","cl":"","p":"{\"address_format\":\"0_10_5\",\"time_format\":\"%E.%m.%Y_%H:%M:%S\",\"us_units\":0}","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Address\",\"Time Format\"]","s":"[\"address_format\",\"time_format\",\"us_units\"]"}],"id":0,"itemId":'$itemId',"callMode":"create"}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=$method&sid=$sid&lang=ru"`

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "Report creation error";
fi

# Get report id
reportId=`expr match "$response" '.\([0-9]*\),'`

################################
# Update report
################################

# Params list
params='{"n":"Edited report","ct":"avl_unit","p":"{\"bind\":null}","tbl":[{"n":"unit_trips","l":"Поездки","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Все сообщения на карте\",\"Треки поездок\"]","s":"[\"render_msgs\",\"render_trips\"]"},{"n":"geozones","l":"Геозоны","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Геозоны\"]","s":"[\"render_geozones\"]"},{"n":"unit_videos","l":"Видео","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Маркеры видео\"]","s":"[\"render_unit_videos\"]"},{"n":"unit_fillings","l":"Заправки","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Маркеры заправок\"]","s":"[\"render_filling_markers\"]"},{"n":"unit_photos","l":"Изображения","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Маркеры изображений\"]","s":"[\"render_unit_photos\"]"},{"n":"unit_stops","l":"Остановки","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Маркеры остановок\"]","s":"[\"render_stops_markers\"]"},{"n":"unit_speedings","l":"Превышение скорости","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Маркеры превышений скорости\"]","s":"[\"render_speedings_markers\"]"},{"n":"unit_thefts","l":"Сливы","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Маркеры сливов\"]","s":"[\"render_theft_markers\"]"},{"n":"unit_events","l":"События","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Маркеры событий\"]","s":"[\"render_events_markers\"]"},{"n":"unit_stays","l":"Стоянки","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Маркеры стоянок\"]","s":"[\"render_stays_markers\"]"},{"n":"unit_location","l":"Последние данные","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Последнее местоположение\"]","s":"[\"render_location_markers\"]"},{"n":"pois","l":"POI","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Группировать иконки\",\"Нумерация маркеров\",\"Учитывать масштаб видимости геозон\"]","s":"[\"group_markers\",\"number_markers\",\"use_visibility_scales\"]"},{"n":"unit_stats","l":"Статистика","f":0,"c":"","cl":"","p":"{\"address_format\":\"0_10_5\",\"time_format\":\"%E.%m.%Y_%H:%M:%S\",\"us_units\":0}","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Address\",\"Time Format\"]","s":"[\"address_format\",\"time_format\",\"us_units\"]"},{"n":"unit_stats","l":"Статистика","f":0,"c":"","cl":"","p":"","sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"sl":"[\"Отчет\",\"Объект\",\"Время выполнения отчета\",\"Начало интервала\",\"Конец интервала\",\"Временная зона\",\"Сообщения\",\"Пробег по всем сообщениям\",\"Потрачено\",\"Потрачено по ДИРТ\",\"Потрачено по ДАРТ\",\"Потрачено по ДМРТ\",\"Потрачено по ДУТ\",\"Потрачено по расчету\",\"Ср. расход\",\"Ср. расход по ДИРТ\",\"Ср. расход по ДАРТ\",\"Ср. расход по ДМРТ\",\"Ср. расход по ДУТ (весь пробег)\",\"Ср. расход по ДУТ (пробег по детектору поездок)\",\"Ср. расход по расчету\",\"Нач. уровень\",\"Конеч. уровень\",\"Макс. уровень топлива\",\"Мин. уровень топлива\"]","s":"[\"report_name\",\"unit_name\",\"current_time\",\"time_begin\",\"time_end\",\"timezone\",\"msgs_count\",\"mileage\",\"fuel_consumption_all\",\"fuel_consumption_imp\",\"fuel_consumption_abs\",\"fuel_consumption_ins\",\"fuel_consumption_fls\",\"fuel_consumption_math\",\"avg_fuel_consumption_all\",\"avg_fuel_consumption_imp\",\"avg_fuel_consumption_abs\",\"avg_fuel_consumption_ins\",\"avg_fuel_consumption_fls\",\"avg_fuel_consumption_fls_td\",\"avg_fuel_consumption_math\",\"fuel_level_begin\",\"fuel_level_end\",\"fuel_level_max\",\"fuel_level_min\"]"},{"l":"График","c":"[\"instant_speed_base\"]","n":"unit_chart","cl":"[\"Скорость\"]","sl":"","s":"","f":0,"sch":{"y":0,"m":0,"w":0,"f1":0,"f2":0,"t1":0,"t2":0},"p":"{\"sensor_mask\":\"*\"}"}],"id":'$reportId',"itemId":'$itemId',"callMode":"update"}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=$method&sid=$sid"`

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "Report update error - $response";
fi

################################
# Execute report
#   from - 2016 December 09 12:00 am
#   to   - 2016 December 09 11:59 pm
################################

# Params list
params='{"reportResourceId":'$itemId',"reportTemplateId":'$reportId',"reportTemplate":"Edited report","reportObjectId":'$newObjectID',"reportObjectSecId":0,"interval":{"flags":16777216,"from":1481230800,"to":1481317199}}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/exec_report&sid=$sid"`

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "Report execution error - $response";
elif [ ${response:1:14} != '"reportResult"' ]; then
    error "Can't execute report with id:$reportId"
fi

################################
# Export to file
################################

# Params list
params='{"format":32,"compress":0}'
file='update_report.csv'

# Execute command and compare with equivalent
curl -s --data-urlencode "params=$params" "$server?svc=report/export_result&sid=$sid" | sed 3d > $file

diff --ignore-all-space update_report.csv update_report.eq.csv > /dev/null

if [ $? -ne 0 ]; then
    error "CSV files different"
fi

rm $file

################################
# Render json
################################

# Params list
params='{"attachmentIndex":0,"width":658,"useCrop":0,"cropBegin":0,"cropEnd":0}'

response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/render_json&sid=$sid"`
equivalent='{"datasets":{"0":{"name":"Скорость, km\/h","color":14319927,"y_axis":0,"data":{"x":[1481276088,1481276093,1481276099,1481276110,1481276154],"y":[0,0,0,0,0]},"colors":[]}}}'

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "Report delete error - $response";
elif [ "$response" != "$equivalent" ]; then
    error "Render json error"
fi

################################
# Select results rows
################################

# Params list
params='{"tableIndex":-1,"config":{"type":"range","data":{"from":0,"to":24,"level":0}}}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/select_result_rows&sid=$sid" | sed 's/"Время выполнения отчета","[^"]*"//g'`
equivalent='[{"n":0,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Отчет","Edited report"]},{"n":1,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Объект","update_report"]},{"n":2,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":[]},{"n":3,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Начало интервала","08.12.2016 21:00:00"]},{"n":4,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Конец интервала","09.12.2016 20:59:59"]},{"n":5,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Временная зона","GMT +0:00"]},{"n":6,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Сообщения","5"]},{"n":7,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Пробег по всем сообщениям","0.00 km"]},{"n":8,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Потрачено","0 lt"]},{"n":9,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Потрачено по ДИРТ","0 lt"]},{"n":10,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Потрачено по ДАРТ","0 lt"]},{"n":11,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Потрачено по ДМРТ","0 lt"]},{"n":12,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Потрачено по ДУТ","0 lt"]},{"n":13,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Потрачено по расчету","0 lt"]},{"n":14,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Ср. расход","0 lt\/100 km"]},{"n":15,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Ср. расход по ДИРТ","0 lt\/100 km"]},{"n":16,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Ср. расход по ДАРТ","0 lt\/100 km"]},{"n":17,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Ср. расход по ДМРТ","0 lt\/100 km"]},{"n":18,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Ср. расход по ДУТ (весь пробег)","0 lt\/100 km"]},{"n":19,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Ср. расход по ДУТ (пробег по детектору поездок)","0 lt\/100 km"]},{"n":20,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Ср. расход по расчету","0 lt\/100 km"]},{"n":21,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Нач. уровень","0 lt"]},{"n":22,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Конеч. уровень","0 lt"]},{"n":23,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Макс. уровень топлива","0 lt"]},{"n":24,"i1":0,"i2":4,"t1":1481230800,"t2":1481317199,"d":0,"c":["Мин. уровень топлива","0 lt"]}]'

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "Report delete error - $response";
elif [ "$response" != "$equivalent" ]; then
    error "Data isn't equal"
fi


################################
# Get point on chart
# method: hittest_chart
################################

# Params list
params='{"attachmentIndex":0,"datasetIndex":-1,"valueX":1481276154,"valueY":0,"flags":5}'

# Execute command and compare with equivalent
response=`curl -s --data-urlencode "params=$params" "$server?svc=report/hittest_chart&sid=$sid"`

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "hittest_chart error - $response";
fi


################################
# Get result chart
################################

# Params list
params='{"attachmentIndex":0,"action":0,"width":400,"height":200,"autoScaleY":0,"pixelFrom":0,"pixelTo":0,"flags":0}'

# File name for saving
file='file.png'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/get_result_chart&sid=$sid" > $file`
response=`file $file`
equivalent=$file': PNG image data, 400 x 200, 8-bit/color RGBA, non-interlaced'

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "Report delete error - $response";
elif [ "$response" != "$equivalent" ]; then
    error "PNG isn't correct"
fi

rm $file

################################
# Get result map
################################

# Params list
params='{"width":200,"height":200}'

file='image.png'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=report/get_result_map&sid=$sid" > $file`
response=`file $file`

equivalent=$file': PNG image data, 200 x 200, 8-bit/color RGBA, non-interlaced'

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "Get result map error - $response";
elif [ "$response" != "$equivalent" ]; then
    error "PNG image error - $response"
fi

rm $file

################################
# Cleanup report results
################################

bash ./cleanup_result.sh

################################
# Delete report
################################

# Params list
params='{"id":'$reportId',"itemId":'$itemId',"callMode":"delete"}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=$method&sid=$sid"`
equivalent="[$reportId,null]"

# Check is error
if [ ${response:0:8} == '{"error"' ]; then
    error "Report delete error - $response";
elif [ "$response" != "$equivalent" ]; then
    error "Can't delete report with id:$reportId"
fi

################################
# Delete Item
################################

# Params list
params='{"itemId":'$newObjectID'}'

# Execute command and compare with equivalent
response=`curl -sX POST --data-urlencode "params=$params" "$server?svc=item/delete_item&sid=$sid"`
equivalent="{}"

# Check is error
if [[ ${response:0:8} == '{"error"' ]]; then
    error "Report delete error - $response";
elif [[ "$response" != "$equivalent" ]]; then
    error "Can't delete item with id:$newObjectID"
fi