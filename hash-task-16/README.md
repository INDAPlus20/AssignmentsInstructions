# DD1338 Week 16

## Database Management Systems (and lots of hash!)

This week we are doing substances! Äh öh ehmm, ja, ehm, I mean hash, hashing, lots of it!

We have already fought through logiken and dtek:en, lets sprinkel on some dbas; one more profesion paradigm for y'all. 

![Data Propaganda](https://pics.me.me/excel-2016-desktop-app-is-this-a-database-the-users-42255119.png)

### Prepare for your assigment

1) Create a repository named `<KTH_ID>-hash`.
2) Clone your newly created repository and start coding.

To make your Kattis-experience easier, see `./kattis_template/src/main.rs`. If you're mot all förmodan using Java, make use of [this utility class](https://open.kattis.com/download/Kattio.java?1a0093=) to simplify input-output fast enough to satisfy the judge.

## Assignment

Don't worry! We wont be cooking a full relational database... _yet_ (hälsningar från the ghost of future Dena), but rather learning the fundamentals behind them!

This week you'll be implementing a VERY simple database management system, which includes
- CLI interaction for entering, exiting and querying,
  - See [the rust book](https://rust-cli.github.io/book/tutorial/index.html) for how to write a CLI application.
  - Python: Just use input(), duh
- lots of hashmaps, and maybe even trees, and
- file management.

This can be done in any language. However, the hashmaps you use **must** be of your implementation, not from a library! The hashier, the better.

### DBMS

***Required***

The minimal feature requirements for your database system are:
- insertion
- deletion
- select all (list all)
- projection by id (get value of key)

The database can have one of the following formats:
- Structured data, aka. tabled structure. SQL databases follow this format. 
  - You don't have to interpret SQL querying. It's okey to be lazy and come up with something much simpler.
- Semi-structured data, aka. tree/graph structure. JSON and XML follow this format. 
  - Querying formats of semi-structured data varies a lot. Here you can be creative. XPath (XML querying) use paths with conditions to query data; for example: `my/data/with[title="hash"]/lots/*`. Once again, you only have to implement very simple querying (literally only a couple of query requests).

The minimal requirements doesn't include the features of creating and deleting tables/pools. Therefore, your minimal database will only have one giant table, simply a huge key-value store. Multible instances of this store can be configured at startup by entering configuration parameters, but this is not a reqirement. 

Every modification of the database has to be saved long term. This is usually done by a file manager concurrently so that other parts of the database, like the query manager and query executor can run uninterupted. You may multithread your application, but this is far from nessecery at this scale! You have to simply maintain a CVS file (or simular) of your data store. This file can in term be read to restore the database at startup or application crash. 

***_(optional fun)_***:
- Add additional data-definition features, like create a table/pool.
- Add additional querying features, like projection by condition.
- A database usually maintain a log which allows for backtracking in case of a bad query. Add a log and regret feature.
- Transactions are groups of database queries. Transactions must me performed in isolation in relation to each other. A transaction manager can identify and handle conflicts between transactions, thereby allowing multible sets of queries to run concurrently on the database. Implement so that single queries are run as transactions and that multible queries can be grouped as transactions. 
- Networking. Usually a database is accessed through the web. 
  - Authentication. A token is often enough.

### Hashmap Requirements

The hashmap requirements are that your implementation has to be capable, in addition to serve as the buffer for your database, to dynamically resize its base arrays when nessesary. See regular task for basic guidance. Also, the one and only fabled Ric's lecture is recommended to, at the very least, scroll through. However, notice that dynamic memory allocation is not a reqirement of the regular task. Vectors and structures like ArrayLists can be of assistance for those who feel a great burden. 

You are also required to implement your own hashing function!
