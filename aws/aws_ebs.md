# Storing your data on hard drives: EBS and instance store

Block-level storage with a disk file system (FAT32, NTFS, ext3, ext4, XFS, and so on) can be used to store files as we do on a personal computer. 

A block is a sequence of bytes and the smallest addressable unit. The OS is the intermediary between the application that wants to access files and the underlying file system and block-level storage. The disk file system manages where (at what block address) your files are persisted on the underlying block-level storage. We can use block-level storage only in combination with an EC2 instance where the OS runs.

---

The OS provides access to block-level storage via open, write, and read system calls. The simplified flow of a read request goes like this:

1.  An application wants to read the file /path/to/file.txt and makes a read system call.

2.  The OS forwards the read request to the file system.

3.  The file system translates /path/to/file.txt to the block on the disk where the data is stored.

Applications like databases that read or write files by using system calls must have access to block-level storage for persistence. _We can’t tell a MySQL database to store its files in an object store because MySQL uses system calls to access files._

---

AWS provides two kinds of block-level storage:
1. **Network-attached storage (NAS):**
    - NAS is (like iSCSI) attached to your EC2 instance via a network connection.
    - EBS provides NAS storage in AWS.
    - NAS is the best choice for most problems because it provides 99.999% availability of the data.
2. **Instance storage:**:
    - instance storage is a normal hard disk that the host system provides to your EC2 instance.  
    - Instance storage is interesting if we’re optimizing for performance. 


# NETWORK-ATTACHED STORAGE

* Elastic Block Store (EBS) provides network-attached, block-level storage with 99.999% availability.
* EBS volumes are independent resources but can only be used when attached to an EC2 instance.
* _We can’t attach the same EBS volume to multiple servers!_

* EBS volumes:
    - Aren’t part of EC2 instances; they’re attached to EC2 instance via a network connection. 
    - If we terminate the EC2 instance, the EBS volumes remain.
    - Can be attached to no EC2 instances or one EC2 instance at a time.
    - Can be used like normal hard disks.
    - Are comparable to RAID1: data is saved to multiple disks in the background.

    






