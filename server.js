const express = require('express');
const fs = require('fs');
const path = require('path');
const archiver = require('archiver');
const multer = require('multer');
const unzipper = require('unzipper');

const app = express();
const PORT = process.env.PORT || 3000;

// Define the storage for multer to place the zip file in /WorldBackup
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, '/WorldBackup');  // Place the uploaded file in /WorldBackup
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);  // Save the file with its original name
  }
});

const upload = multer({ storage: storage });

// Endpoint to download /WorldBackup volume contents
app.get('/download-backup', (req, res) => {
  const volumePath = '/WorldBackup';  // Adjust the path
  const archivePath = path.join(__dirname, 'world-backup.zip');
  
  // Create a zip file and stream it
  const output = fs.createWriteStream(archivePath);
  const archive = archiver('zip', {
    zlib: { level: 9 }  // Compression level
  });

  output.on('close', function() {
    console.log(archive.pointer() + ' total bytes');
    console.log('WorldBackup has been archived.');
    
    // Send the file to the client for download
    res.download(archivePath, 'world-backup.zip', function(err) {
      if (err) {
        console.error(err);
      } else {
        // Optionally delete the archive after sending
        fs.unlinkSync(archivePath);
      }
    });
  });

  // Catch any errors
  archive.on('error', function(err) {
    throw err;
  });

  // Pipe archive data to the file
  archive.pipe(output);

  // Append files from the volume directory
  archive.directory(volumePath, false);

  // Finalize the archive
  archive.finalize();
});

// Endpoint to upload a zip file and extract it in /WorldBackup
app.post('/upload-backup', upload.single('file'), (req, res) => {
  const filePath = path.join('/WorldBackup', req.file.originalname);

  // Check if the uploaded file is a zip
  if (path.extname(req.file.originalname) !== '.zip') {
    return res.status(400).send('Only zip files are allowed!');
  }

  // Extract the zip file
  fs.createReadStream(filePath)
    .pipe(unzipper.Extract({ path: '/WorldBackup' }))
    .on('close', () => {
      console.log('File extracted successfully.');
      // Optionally delete the zip file after extraction
      fs.unlinkSync(filePath);
      res.send('File uploaded and extracted successfully.');
    })
    .on('error', (err) => {
      console.error(err);
      res.status(500).send('Error extracting the file.');
    });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
