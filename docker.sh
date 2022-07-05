##Docker image

Docker image mirip seperti instaler applikasi, dimna di dalam docker image terdapat applikasi dan dependency
Sebelum kita bisa menjalankan appliaksi di docker, kita pastikan kita sudah mempunyai docker image appliklasi
tersebut

##Melihat docker image

untuk melihat docker image yang terdapat pada docker daemon (docker server kita) kita bisa menggunakan perintah
docker image ls

## Download docker image 

Untuk download docker image dari Docker registry kita bisa gunakan printah;
docker image pull namaImage:tagnya
kita bisa mencari docker image di https://hub.docker.com/search?q=

##menghaopus docker image 
untuk menghapus iamge yang tidak kita perlukan kita bisa menggunkan command
docker image rm namaImage:tagnya

## Docker Container
jika docker image seperti installer appliaksi maka docker container mirip seperti applikasi
hasil installer nya
satu docker image bisa di gunakan untuk membuat beberapa docker container asalkan nama docker container nya beda
Jika kita sudah membuat docker container maka docker image yang kita gunakan tidak bisa kita hapus
hal ini di karnakan sebenarnya docker container tidak mengcopy isi docker image tetapi hanya menggunakan isinya saja
kecuali kita menghapus docker container nya baru image nya bisa di hapus

## Status Container
Saat kita membuat Container, secara default container tersebut tidak akan berjalan
miirip seperti kita menginstall applikasi, jika kita tidak menjalankanya maka applikasi tersebut tidak akan jalan begitu juga container
Oleh karna itu, setalah membaut coantainer kita perlu menjalankanya jika memang ingin menjalnjan container nya

## Melihat container
untuk melihat semua container yang sedang berjalan maupun tidak di docker Daemon (docker server)
kita bisa gunakan perintah :
docker container ls -a 
sedangkan jika kita ingin melihat container yang sedang berjalan saja kita bisa gunakan perintah :
docker container ls 

## Membuat container 
Untuk membuat container kita bisa gunakan perintah :
docker container create --name namaContainernya namaImage:tagnya

## menjalankan container
docker container start namaCointaianer nya

## menberhentikan container
sebelum menghapus container hentikan terlebih dahulu container nya dengan command sebagai brkt :
docker container stop namaContainernya

## menghapus container
docker container rm namaContainernya

## melihat container log
Untuk melihat log di contaner applikasi kita kiTA bisa menggunkaan perintah : 
docker contaner logs namaContainernya
Atau jika ingin melihat secara realtime kita bisa gunakan perintah : 
docker container logs -f namaContainernya

## Container exec
Saat kita membuat container appliaksi yang terdapat didalam container hanya bisa diakses dari dalam coantainer
Oleh karna itu kadang kita perlu masuk ke dalam container nya itu sendiri
Untuk masuk ke dalam container kita bisa menggunkan fitur container exec , yang mana digunkan untuk mengeksekusi kode program
yang terdapat disalam container

## Masuk ke container
Untuk mausk ke dalam container, kita bisa mengeksekusi program bash script yang terdapat didalam container dengan bantuan container exec
docker container exec -i -t namaCointaianer /bin/bash
-i adalah argumen interaktif, menjaga input tetap aktif (agar kita bisa mengeksekusi command di dalam container nya)
-t adalah argument untuk alokasi pseudo-TTY(terminal akses)
/bin/bash contoh kode program yang terdapat didalam container


## Port forwarding
Docker memiliki kemampuan untuk melakukan poret forwarding, yaitu meneruskan sebuah port yang terdapat di sistem host nya ke dalam docker container
cara ini cocok jika kita ingin mengekspos port yang terdapat di container ke luar melalui sistem host nya

## melakukan port forwarding
utnuk melakukan port forwarding kita bisa menggunakan perintah berikut ketika membuat container nya : 
docker container create --name namaContainernya --publish portHost:portContainer namaImage:tagnya
jika kita ingin melakukan portForwarding lebih dari 1, kita bisa menambahkan 2x parameter --publish
--publish juga bisa disingkat menjadi -p

## container enverionment variable
menggunakan Enverionment variable salahsatu cara agar konfigurasi appliaksi bisa diubah secara dinamis
dengan menggunakan enverionment variable kita bisa mengubah ubah konfigurasi appllikasi tampa harus megubah kode applikasinnya lagi
docker container memiliki parameter yang bisa kita gunakan untuk mengirim enverionment variable ke appliaksi yang terdapat didalam container

## menambahkan enverionment variable
Untuk menambahkan enverionment variable kita bisa meambahakan command --env atau -e contoh : 
docker container create --name nameContainer --env=value --env=value namaImage:tagnya

example : 
docker container create --name mongoDb --publish 27017:27017 --env MONGO_INITDB_ROOT_USERNAME=alliano-dev --env MONGO_INITDB_ROOT_PASSWORD=example mongo:latest
docker container create --name mysql --publish 3306:3306 --env MYSQL_ROOT_PASSWORD=alliano-dev --env MYSQL_USER=alliano-dev --env MYSQL_PASSWORD=test mysql:latest 

## docker container stats 
sat menjalankan beberapa container di system Host penggunaan resource seperti CPU dan Memory hanya terlihat digunakan oleh Docker saja
kadang kita ingin melihat detail dari penggunakan resource untuk tiap container nya 
docker memiliki kemampuan untuk melihat resource utnuk tiap containernya yang sedang berjalan 
untuk meelihat resource nya kita bisa gunnakan perintah :
docker container stats

## Limit resource

## limit memory
kita bisa mennetukan jumlah memory yang bisa digunakan oleh container dengan menggunkan perintah --memory diikuti dengan angaka memory
yang diperbolehkan untuk digunakan
kita bisa menambahkan ukuran dengan bentuk b (bytes), k (kilo bytes), m (mega bytes), g (giga bytes) misal 100m artinya 100 mega bytes

## limit CPU core 
kita juga bisa menentukan berapa jumlah CPU yang bisa digunakan oleh CPU dengan parameter --cpus 
jika misal kita set dengan nilai 1.5, artinya container bisa menggunakan 1 dari 1/2 (setengah) dari CPU coere  

example : 
docker container create --name smallNginx --publish 8081:80 --memory 100m --cpus 0.5 nginx:latest

## Bind Mounts
Bind mounts merupakan kemampuan melakukan mounting (sharing) file atau folder yang terdapat di system host ke container yang terdapat di docker
fitur ini sangat berguna ketika kita inggin mengirim konfigurasi dari luar container, atau menyimpan data yang dibuat di applikasi didalam container 
ke dalam folder di system host
jika file atau folder tidak ada di system host, secara otomatis akan dibuatkan oleh Docker 
untuk melakukan mounting kita bisa melakukan dengan parameter --mount ketika membuat container 
isi dari parameter --mount memiliki aturan sendiri

## Parameter Mount 
type => tipe mount bind atau volume
source => lokasi file atau folder di system hosr
destination => lokasi file atau folder di container
readonly => jika ada maka file atau folder hanya bisa dibaca di container, tidak bisa ditulis

## Melakukan mounting
Untuk melakukan mounting kita bisa menggunakan perintah berukut :
docker container create --name nameContainer --mount "type=bind,source=path folder si komputer,destination=path destinantion di container, readonly" namaImage:tagnya

example : 
docker container create --name mongoDb2 --mount "type=bind,source=/home/alliano-dev/Latihan/docker/dataBackup,destination=/data/db" --publish 27018:27017 --env=MONGO_INITDB_ROOT_USERNAME=alliano-dev --env MONGO_INITDB_ROOT_PASSWORD="alliano361**" mongo:latest

## Docker volume
fitur bind mount sudah ada sejak docker versi pertama di versi terbaru direkomendasikan untuk menggunkan docker volume
docker volume mirip dengan docker bind mount bedanya adalah terdapat management volume, yang mna kita bisa membuat volume, melihat daftar volume,
dan menghapus volume 
volume sendiri bisa dianggap sebagai setorage yang digunakan untuk menyimpan data, bedanya dengan bind mount adalah data disimpan pada sistem host
sedangkan pada volume data di manage oleh docker

## melihat docker volume
saat kita membuat container secara devault data disimpan didalam volume
jika kita coba melihat volume, ada banyak volume yang sudah terbuat walupun kita belum pernah membuat nya sama sekali

untuk melihat volume kita bisa menggunakan perintah ini : 
docker volume ls

## Membuat volume 
kita bisa menggunakan command ini : 
docker volumee create namaVolume

## Menghapus volume
volume yang tidak kita terpakai oleh container bisa kita hapus, tetapi jika volume digunakan 
oleh container maka tidak bisa kita hapus sampai container nya dihapus
untuk menghapus volume kita bisa menggunakan command :
docker volume rm namaVolume

## Container volume
volume yang sudah kita buat bisa kita gunakan di container
Keuntungan menggunakan volume adalah jika container kita hapus data akan tetap aman di volume 
cara menggunkan volume di docker sama dengan menggunakan bind mount kita bisa menggunakan parameter --mount 
namun dengan menggunakan type volume dan source nya nama volume nya

example :
docker volume create mongovolume
docker container create --name mongoDbVolume --publish 27019:27017 --mount "type=volume,source=mongovolume,destination=/data/db" mongo:latest

## Tahapam melakukan Backup volume
Matikan container yang mengunakan volume yang ingin kita Backup
buat coantainer baru dengan 2 mount, volume yang ingin kita backup dan bind mount folder dari sistem host
Lakukan backup dengan menggunkan container dengan cara meng archive isi volume dan simpan di bind mount folder
rm container yang kita gunakan utnuk melakukan backup

example : 

docker container create --name nginxBackup --mount "type=bind,source=/home/alliano-dev/Latihan/docker/backupVolume,destination=/backupVolume" --mount "type=volume,source=mongovolume,destination=/data" nginx:latest

docker container start nginxBackup

docker container stop mongoDbVolume

docker container exec -it nginxBackup /bin/bash

tar cvf /backupVolume/data-backUp.tar.gz /data

exit

docker container stop nginxBackup

docker container rm nginxBackup  

## Backup volume degan 1x comand line
kita bisa gunakan command run untuk menjalankan perintah di container dan gunkaan parameter --rm untuk melakukan otomatis remove container setelah printahnya selesai berjalan

example : 
docker container run --rm --name redisBackup --mount "type=bind,source=/home/alliano-dev/Latihan/docker/backupVolume,destination=/backupVolume" --mount "type=volume,source=mongovolume,destination=/data" redis:latest tar cvf /backupVolume/data-backup2.tar.gz /data

## Tahapan melakukan restore
buat volume baru untuk lokasi restore data backup 
buat container baru dengan 2 mount, volume baru untuk restore backup dan bind mount folder dari sistem host yang berisi file backup
Lakukan restore dengan menggunkan container dengan cara mengekstrak backup file kedalam volume
Isi file backup sekarang sudah direstore ke dalam volume

example : 
docker volume create mongorestore

docker container run --rm --name redisBackup --mount "type=bind,source=/home/alliano-dev/Latihan/docker/backupVolume,destination=/backupVolume" --mount "type=volume,source=mongorestore,destination=/data" redis:latest bash -c "cd /data && tar xvf /backupVolume/data-backup2.tar.gz --strip 1"

docker container create --name mongoDbRestore --mount "type=volume,source=mongorestore,destination=/data/" --publish 27020:27017 --env=MONGO_INITDB_ROOT_USERNAME=alliano-dev --env MONGO_INITDB_ROOT_PASSWORD="alliano361**" mongo:latest

## Docker network
secara default container akan terisolasi satu sam yang lainya, jadi jika kita mencoba memanggil antar container, bisa dipastikan bahwa kita tidakakn bisa
melakukanya
Docker memiliki fitur network yang bisa digunakan untuk membuat jaringan didalam docker
Dengan menggunkan network kita bisa mengkoneksikan container dengan container yagng lain dalam 1 network yang sama
jika bebebrapa container terdapat dalam 1 network yang sama, maka secara otomatis container tersebut dapat saling berkomuikasi

## Docker network
Saat kita membuat network di docker kita perlu menentukan driver yang ingin di gunakan, ada banyak driver yang bisa kita gunkana
1. bridge yaitu driver yang digunakan untuk membuat network secara virtual yang memungkinkan container yang terkoneksi di bridge network
   yang sama saling berkomunikasi
2. host, yaitu driver yang digunakan untuk membuat network yang sama dengan sistem host. dirver host hanya bisa jalan di system operasi Linux
   tidak bisa digunakan di mac ataupun windows
3. none, yaitu driver untuk membuat network yang tidakbisa berkomunikasi. secara default saat kita membaut container menggunkan etwork ini 

## Melihat network
docker network ls

## Membuat network
Untuk membuat network kita bisa menggunkana command : 
docker network create --driver namaDriver namaNetworknya

## Menghapus network
gunkana command : 
docker network rm namaNetworknya
network tidakbisa kita hapus jikalau sudah digunakan oleh container, kita harus menghapus container nya terlebih dahulu sebelum menghapus Networknya

## Container Network
Setelah kita membuat network kita bisa menmbahkan container ke network 
Container yang teredapat didalam network yang sama bisa saling berkomunikasi (tergantung jenis driver network nya)
Container bisa meng akses container lain dengan menyebutkan hostname dari containernya, yaityu nama container

## Membuat Container Dengan Network
Untuk menambahkan Container ke network, Kita bisa menambahkan perintah --network ketika membuat Container
cnth : 
docker container create --name namaContainernya --network namaNetworknya image:tagnya

example : 
docker network create --driver bridge mongonetwork

docker container create --name mongodb --network mongonetwork --env MONGO_INITDB_ROOT_USERNAME=alliano-dev --env MONGO_INITDB_ROOT_PASSWORD=example mongo:latest

docker image pull mongo-express:latest

docker container create --name mongodbexpress --network mongonetwork --publish 8081:8081 --env  ME_CONFIG_MONGODB_URL="mongodb://alliano-dev:example@mongodb:27017/" mongo-express:latest

## menghapus container dari network 
kita juga bisa menghapus container dari network dengan perintah : 
docker network disconnect namaNetworknya namaCointaianer

example : 
docker network disconnect mongonetwork mongodb
dengan begini maka container mongodb tidak se network lagi dengan mongodbexpress (mongodb tidak dalam network mongonetwork)

## menambahkan container ke network
jika container telah terlanjur dibuat atau kita sudah disconnect container dengan network, kita bisa menambahkan container yang sudah
dibuat atau sudah di disconnect ke network dengan perinatah : 
docker network connect namaNetworknya namaContainernya

example : 
docker network connect mongonetwork mongodb

## inspect
setelah kita mendownload image atau membaut network,volume,container kadang kita ingin meilhat detail dari dari tiap2 hal tersebut
misal kita ingi melihat detail dari image, printah apa yang digunakan oleh image tersebut?, env apa yang digunakan atau port apa yg digunakan
kita juga bisa meelihat detail dari container 
docker memiliki fitur yang namanya inspec untuk meilhat detail dari volume,image,container,network

## Menggunakan inspec
Untuk melihat detail image gunakan : docker image inspect namaImage
Untuk melihat detail network gunakan : docker network inspect namaNetworknya
Untuk melihat detail container gunakan : docker container inspect namaContainernya
Untuk melihat detail volume gunakan : docker volume inspect namaVolume

## Prune
Saat kita menggunakan docker kadang ada kalanya kita ingin membersihkan hal hal yang sudah tidak digunakan oleh docker seperti image yg tek terpakai
container yang udah di stop atau volume yg tidak digunakan atau network yang tidak terpakai
untuk membersihkanya atau menghapus secara otomatis kita bisa gunakan command prune 
hampir semua perintah di docker mendukung prune

## printah prune
menghapus container yang sudah stop : 
docker container prune

menghapus volume yang sudah tidak digunakan : 
docker volume prune

menghapus iamge yang sudah tidak digunakan : 
docker image prune

menghapus network yang sudah tidak digunakan : 
docker network prune