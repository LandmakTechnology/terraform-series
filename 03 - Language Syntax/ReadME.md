# Terraform Configuration Language Syntax

## **Step-01: Blocks**
https://www.terraform.io/docs/configuration/syntax.html
# a) **Understand Blocks**
      - Terraform Settings Block
      - Provider Block
      - Resource Block
      - Input Variables Block
      - Output Values Block
      - Local Values Block
      - Data Sources Block
      - Modules Block

- A block is a container for other content:
# Template

     <BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>"   {
       # Block body
      <IDENTIFIER> = <EXPRESSION> # Argument
     }

# AWS Example
resource "aws_instance" "ec2demo" {
  # BLOCK BODY
  ami           = "ami-04d29b6f966df1537" # Argument
  instance_type = var.instance_type # Argument with value as expression (Variable value replaced from varibales.tf

      network_interface {
       # ...
    }
  }

- A block has a type (resource in this example). Each block type defines how many labels must follow the type keyword. The resource block type expects two labels, which are aws_instance and ec2demo in the example above. A particular block type may have any number of required labels, or it may require none as with the nested network_interface block type.

- After the block type keyword and any labels, the block body is delimited by the { and } characters. Within the block body, further arguments and blocks may be nested, creating a hierarchy of blocks and their associated arguments.

## **Step-02: Arguments, Expressions, Attributes & Meta-Arguments**

# Arguments
  -They assign a value to a name. They appear within blocks. Arguments can be required or optional.

# Expressions
- They represent a value, either literally or by referencing and combining other values. They appear as values for arguments, or within other expressions.

# Attributes
- They represent a named piece of data that belongs to some kind of object. The value of an attribute can be referenced in expressions using a dot-separated notation, like aws_instance.example.id.
- The format looks like `resource_type.resource_name.attribute_name`

# Identifiers
- Argument names, block type names, and the names of most Terraform-specific constructs like resources, input variables, etc. are all identifiers.

- Identifiers can contain letters, digits, underscores (_), and hyphens (-). The first character of an identifier must not be a digit, to avoid ambiguity with literal numbers.

# Comments
- The Terraform language supports three different syntaxes for comments:

The # begins a single-line comment, ending at the end of the line.
// also begins a single-line comment, as an alternative to #.
/* and */ are start and end delimiters for a comment that might span over multiple lines.
The # single-line comment style is the default comment style and should be used in most cases. Automatic configuration formatting tools may automatically transform // comments into # comments, since the double-slash style is not idiomatic.

# Meta-Arguments
(https://www.terraform.io/docs/language/meta-arguments/)
- Meta-Arguments change a resource type's behavior (Example: count, for_each)

 **depends_on**
   - The depends_on meta-argument, if present, must be a list of references to other resources or child modules in the same calling module. Arbitrary expressions are not allowed in the depends_on argument value, because its value must be known before Terraform knows resource relationships and thus before it can safely evaluate expressions.

 **Count**
   - The count meta-argument accepts numeric expressions. However, unlike most arguments, the count value must be known before Terraform performs any remote resource actions. This means count can't refer to any resource attributes that aren't known until after a configuration is applied
   - In blocks where count is set, an additional count object is available in expressions, so you can modify the configuration of each instance. This object has one attribute: **count.index** — The distinct index number (starting with 0) corresponding to this instance.

 **for_each**
  - If your instances are almost identical, count is appropriate. If some of their arguments need distinct values that can't be directly derived from an integer, it's safer to use for_each.
  - The for_each meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.
  - In blocks where for_each is set, an additional each object is available in expressions, so you can modify the configuration of each instance. This object has two attributes:

      each.key — The map key (or set member) corresponding to this instance.
      each.value — The map value corresponding to this instance. (If a set was provided, this is the same as each.key.)
  - The for_each value must be a map or set with one element per desired resource instance. When providing a set, you must use an expression that explicitly returns a set value, like the toset function; to prevent unwanted surprises during conversion, the for_each argument does not implicitly convert lists or tuples to sets.
  -toset converts its argument to a set value. Explicit type conversions are rarely necessary in Terraform because it will convert types automatically where required. Use the explicit type conversion functions only to normalize types returned in module outputs. Pass a list value to toset to convert it to a set, which will remove any duplicate elements and discard the ordering of the elements.

  # map
  resource "azurerm_resource_group" "rg" {
    for_each = {
      a_group = "eastus"
      another_group = "westus2"
    }
    name     = each.key
    location = each.value
  }

  # Set of strings
    resource "aws_iam_user" "the-accounts" {
      for_each = toset( ["Todd", "James", "Alice", "Dottie"] )
      name     = each.key
   }

 **lifecycle**
