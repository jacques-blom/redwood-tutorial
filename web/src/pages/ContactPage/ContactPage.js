import {
  FieldError,
  Form,
  Submit,
  TextAreaField,
  TextField,
  FormError,
} from '@redwoodjs/forms'
import { Flash, useFlash, useMutation } from '@redwoodjs/web'
import BlogLayout from 'src/layouts/BlogLayout/BlogLayout'
import { useForm } from 'react-hook-form'

const CREATE_CONTACT = gql`
  mutation CreateContactMutation($input: CreateContactInput!) {
    createContact(input: $input) {
      id
    }
  }
`

const ContactPage = () => {
  const { addMessage } = useFlash()
  const [create, { loading, error }] = useMutation(CREATE_CONTACT, {
    onCompleted: () => {
      addMessage('Thank you for your submission!', {
        style: { backgroundColor: 'green', color: 'white', padding: '1rem' },
      })
      formMethods.reset()
    },
  })
  const formMethods = useForm()

  const onSubmit = (data) => {
    create({ variables: { input: data } })
  }

  return (
    <BlogLayout>
      <Flash timeout={2000} />
      <Form onSubmit={onSubmit} error={error} formMethods={formMethods}>
        {error && (
          <FormError
            error={error}
            wrapperStyle={{ color: 'red', backgroundColor: 'lavenderblush' }}
          />
        )}
        <label htmlFor="name">Name</label>
        <TextField
          name="name"
          validation={{ mode: 'onBlur', required: true }}
          errorClassName="error"
        />
        <FieldError name="name" className="error" />

        <label htmlFor="email">Email</label>
        <TextField
          name="email"
          validation={{
            // mode: 'onBlur',
            required: true,
            // pattern: {
            //   value: /[^@]+@[^.]+\..+/,
            // },
          }}
          errorClassName="error"
        />
        <FieldError name="email" className="error" />

        <label htmlFor="message">Message</label>
        <TextAreaField
          name="message"
          validation={{ mode: 'onBlur', required: true }}
          errorClassName="error"
        />
        <FieldError name="message" className="error" />

        <Submit disabled={loading}>Save</Submit>
      </Form>
    </BlogLayout>
  )
}

export default ContactPage
