namespace :db do
  desc "This task backs up the Mongo DB to local dump as compressed gzip."
  task :backupMembers do
    sh("mongodump --db makerauth --collection members --out - | gzip > /home/putter/server/makerspace-interface/dump/members/memberBackup_#{Time.now.strftime('%m-%d-%Y')}.gz")
    GoogleDrive::Session.from_config("config.json").upload_from_file("/home/putter/server/makerspace-interface/dump/members/memberBackup_#{Time.now.strftime('%m-%d-%Y')}.gz", "memberBackup_#{Time.now.strftime('%m-%d-%Y')}.gz", convert: false)
  end

  task :backupWorkshops do
    sh("mongodump --db makerauth --collection workshops --out - | gzip > /home/putter/server/makerspace-interface/dump/workshops/workshopBackup_#{Time.now.strftime('%m-%d-%Y')}.gz")
    GoogleDrive::Session.from_config("config.json").upload_from_file("/home/putter/server/makerspace-interface/dump/workshops/workshopBackup_#{Time.now.strftime('%m-%d-%Y')}.gz", "workshopBackup_#{Time.now.strftime('%m-%d-%Y')}.gz", convert: false)
  end

  task :backupSkills do
    sh("mongodump --db makerauth --collection skills --out - | gzip > /home/putter/server/makerspace-interface/dump/skills/skillBackup_#{Time.now.strftime('%m-%d-%Y')}.gz")
    GoogleDrive::Session.from_config("config.json").upload_from_file("/home/putter/server/makerspace-interface/dump/skills/skillBackup_#{Time.now.strftime('%m-%d-%Y')}.gz", "skillBackup#{Time.now.strftime('%m-%d-%Y')}.gz", convert: false)
  end

  task :backupPayments do
    sh("mongodump --db makerspacepayments --collection generals --out - | gzip > /home/putter/server/makerspace-interface/dump/payments/paymentBackup_#{Time.now.strftime('%m-%d-%Y')}.gz")
    GoogleDrive::Session.from_config("config.json").upload_from_file("/home/putter/server/makerspace-interface/dump/payments/paymentBackup_#{Time.now.strftime('%m-%d-%Y')}.gz", "paymentBackup#{Time.now.strftime('%m-%d-%Y')}.gz", convert: false)
  end
end
