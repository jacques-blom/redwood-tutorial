# Migration `20201015173919-create-posts`

This migration has been generated at 10/15/2020, 7:39:19 PM.
You can check out the [state of the schema](./schema.prisma) after the migration.

## Database Steps

```sql
CREATE TABLE "UserExample" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "name" TEXT
)

CREATE TABLE "Post" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE UNIQUE INDEX "UserExample.email_unique" ON "UserExample"("email")
```

## Changes

```diff
diff --git schema.prisma schema.prisma
migration ..20201015173919-create-posts
--- datamodel.dml
+++ datamodel.dml
@@ -1,0 +1,27 @@
+datasource DS {
+  // optionally set multiple providers
+  // example: provider = ["sqlite", "postgresql"]
+  provider = "sqlite"
+  url = "***"
+}
+
+generator client {
+  provider      = "prisma-client-js"
+  binaryTargets = "native"
+}
+
+// Define your own datamodels here and run `yarn redwood db save` to create
+// migrations for them.
+// TODO: Please remove the following example:
+model UserExample {
+  id    Int     @id @default(autoincrement())
+  email String  @unique
+  name  String?
+}
+
+model Post {
+  id        Int      @id @default(autoincrement())
+  title     String
+  body      String
+  createdAt DateTime @default(now())
+}
```


