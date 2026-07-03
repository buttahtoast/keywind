import Alpine from 'alpinejs';
import { base64url } from 'rfc4648';

type DataType = {
  $refs: RefsType;
  $store: StoreType;
};

type RefsType = {
  authenticatorDataInput: HTMLInputElement;
  authnSelectForm?: HTMLFormElement;
  clientDataJSONInput: HTMLInputElement;
  credentialIdInput: HTMLInputElement;
  errorInput: HTMLInputElement;
  passkeyLoginForm?: HTMLFormElement;
  signatureInput: HTMLInputElement;
  userHandleInput: HTMLInputElement;
  webAuthnForm: HTMLFormElement;
};

type StoreType = {
  passkeys: PasskeysStore;
};

type PasskeysStore = {
  authenticatorAttachment?: AuthenticatorAttachment | string;
  challenge: string;
  createTimeout: string;
  isUserIdentified: boolean | string;
  mediation?: CredentialMediationRequirement | string;
  rpId: string;
  unsupportedBrowserText: string;
  userVerification: UserVerificationRequirement | string;
};

const isTruthy = (value: string | boolean) => value === true || value === 'true';

const credentialOptions = (
  store: PasskeysStore,
  allowCredentials: PublicKeyCredentialDescriptor[] = []
) => {
  const publicKey: PublicKeyCredentialRequestOptions = {
    challenge: base64url.parse(store.challenge, { loose: true }),
    rpId: store.rpId,
  };

  if (allowCredentials.length) publicKey.allowCredentials = allowCredentials;

  const timeout = parseInt(store.createTimeout);
  if (timeout) publicKey.timeout = timeout * 1000;

  if (store.userVerification && store.userVerification !== 'not specified') {
    publicKey.userVerification = store.userVerification as UserVerificationRequirement;
  }

  return publicKey;
};

document.addEventListener('alpine:init', () => {
  Alpine.data('passkeys', function (this: DataType) {
    const refs = this.$refs;
    const store = this.$store.passkeys;

    const collectAllowCredentials = () => {
      const allowCredentials: PublicKeyCredentialDescriptor[] = [];
      const elements = refs.authnSelectForm ? Array.from(refs.authnSelectForm.elements) : [];

      elements.forEach((element) => {
        if (element instanceof HTMLInputElement) {
          allowCredentials.push({
            id: base64url.parse(element.value, { loose: true }),
            type: 'public-key',
          });
        }
      });

      return allowCredentials;
    };

    const submitCredential = (result: PublicKeyCredential) => {
      if (!(result.response instanceof AuthenticatorAssertionResponse)) return;

      refs.authenticatorDataInput.value = base64url.stringify(
        new Uint8Array(result.response.authenticatorData),
        { pad: false }
      );

      refs.clientDataJSONInput.value = base64url.stringify(
        new Uint8Array(result.response.clientDataJSON),
        { pad: false }
      );

      refs.signatureInput.value = base64url.stringify(new Uint8Array(result.response.signature), {
        pad: false,
      });

      refs.credentialIdInput.value = result.id;

      if (result.response.userHandle) {
        refs.userHandleInput.value = base64url.stringify(new Uint8Array(result.response.userHandle), {
          pad: false,
        });
      }

      refs.webAuthnForm.submit();
    };

    const authenticate = (mediation?: CredentialMediationRequirement) => {
      if (!window.PublicKeyCredential) {
        refs.errorInput.value = store.unsupportedBrowserText;
        refs.webAuthnForm.submit();

        return;
      }

      navigator.credentials
        .get({
          mediation,
          publicKey: credentialOptions(
            store,
            isTruthy(store.isUserIdentified) ? collectAllowCredentials() : []
          ),
        })
        .then((result) => {
          if (result instanceof PublicKeyCredential) submitCredential(result);
        })
        .catch((error) => {
          if (mediation === 'conditional') return;

          refs.errorInput.value = error;
          refs.webAuthnForm.submit();
        });
    };

    return {
      passkeyAutofillAvailable: false,
      passkeyFallbackVisible: false,
      authenticatePasskey: () => authenticate(),
      initPasskeyConditionalUI() {
        if (!window.PublicKeyCredential || !PublicKeyCredential.isConditionalMediationAvailable) {
          this.passkeyFallbackVisible = true;

          return;
        }

        PublicKeyCredential.isConditionalMediationAvailable()
          .then((available) => {
            this.passkeyAutofillAvailable = available;
            this.passkeyFallbackVisible = !available;

            if (available) authenticate('conditional');
          })
          .catch(() => {
            this.passkeyFallbackVisible = true;
          });
      },
    };
  });
});
